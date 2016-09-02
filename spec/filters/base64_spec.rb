# encoding: utf-8
require 'spec_helper'
require "logstash/filters/base64"

describe LogStash::Filters::Base64 do
  let(:config) { '''
    filter {
      base64 {}
    }
  ''' }

  describe "Decode nil message" do
    sample("message" => nil) do
      expect(subject.get("message")).to eq(nil)
      expect(subject.get("tags")).to include("_base64failure")
    end
  end

  describe "Decode message" do
    sample("message" => "aGVsbG8=") do
      expect(subject.get("message")).to eq("hello")
      expect(subject.get("tags")).to be nil
    end
  end

  describe "Decode string from a missing field" do
    sample("another_field" => "aGVsbG8=") do
      expect(subject.get("tags")).to include("_base64failure")
    end
  end

  describe "Decode non-base64 messages" do
    sample("message" => "hello") do
      expect(subject.get("message")).to eq("hello")
      expect(subject.get("tags")).to include("_base64failure")
    end
    sample("message" => "{}") do
      expect(subject.get("message")).to eq("{}")
      expect(subject.get("tags")).to include("_base64failure")
    end
    sample("message" => "😁") do
      expect(subject.get("message")).to eq("😁")
      expect(subject.get("tags")).to include("_base64failure")
    end
    sample("message" => 123) do
      expect(subject.get("message")).to eq(123)
      expect(subject.get("tags")).to include("_base64failure")
    end
    sample("message" => false) do
      expect(subject.get("message")).to eq(false)
      expect(subject.get("tags")).to include("_base64failure")
    end
    sample("message" => 3.14) do
      expect(subject.get("message")).to eq(3.14)
      expect(subject.get("tags")).to include("_base64failure")
    end
  end
end

describe LogStash::Filters::Base64 do
  let(:config) { '''
    filter {
      base64 {
        action => "encode"
      }
    }
  ''' }

  describe "Encode nil message" do
    sample("message" => nil) do
      expect(subject.get("message")).to eq(nil)
      expect(subject.get("tags")).to include("_base64failure")
    end
  end

  describe "Encode message" do
    sample("message" => "hello") do
      expect(subject.get("message")).to eq("aGVsbG8=")
      expect(subject.get("tags")).to be nil
    end
  end

  describe "Encode integer" do
    sample("message" => 123) do
      expect(subject.get("message")).to eq(123)
      expect(subject.get("tags")).to include("_base64failure")
    end
  end

  describe "Encode emoji" do
    sample("message" => "😁") do
      expect(subject.get("message")).to eq("8J+YgQ==")
      expect(subject.get("tags")).to be nil
    end
  end
end

describe LogStash::Filters::Base64 do
  let(:config) { '''
    filter {
      base64 {
        field => "my_field"
      }
    }
  ''' }

  describe "Decode string from custom field" do
    sample("my_field" => "aGVsbG8=") do
      expect(subject.get("my_field")).to eq("hello")
      expect(subject.get("tags")).to be nil
    end
  end

  describe "Decode string from a missing custom field" do
    sample("another_field" => "aGVsbG8=") do
      expect(subject.get("tags")).to include("_base64failure")
    end
  end
end

describe LogStash::Filters::Base64 do
  let(:config) { '''
    filter {
      base64 {
        tag_on_failure => "ERROR_TAG"
      }
    }
  ''' }

  describe "Test custom failure tag" do
    sample("message" => nil) do
      expect(subject.get("tags")).to include("ERROR_TAG")
    end
  end
end
