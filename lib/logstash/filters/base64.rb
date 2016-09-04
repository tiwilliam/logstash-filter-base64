# encoding: utf-8
require "base64"

require "logstash/filters/base"
require "logstash/namespace"

class LogStash::Filters::Base64 < LogStash::Filters::Base

  config_name "base64"

  # The type of base64 transformation
  config :action, :validate => ["decode", "encode"], :default => "decode"

  # The field to encode/decode in-place
  config :field, :validate => :string, :default => "message"

  # Append values to the `tags` field on failure
  config :tag_on_failure, :validate => :array, :default => ["_base64failure"]

  private
  def filter_failed(event, tags)
    tags.each {|tag| event.tag(tag)}
  end

  public
  def register
  end

  public
  def filter(event)
    value = event.get(@field)

    if !(value.is_a? String)
      return filter_failed(event, @tag_on_failure)
    end

    begin
      case @action
      when "encode"
        event.set(@field, Base64.strict_encode64(value))
      when "decode"
        event.set(@field, Base64.strict_decode64(value))
      end
    rescue ArgumentError, TypeError
      return filter_failed(event, @tag_on_failure)
    end

    filter_matched(event)
  end
end
