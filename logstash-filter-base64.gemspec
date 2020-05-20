Gem::Specification.new do |s|
  s.name = 'logstash-filter-base64'
  s.version = '1.0.6.pre'
  s.licenses = ['Apache License (2.0)']
  s.summary = "This filter helps you encode and decode fields."
  s.description = "This gem is a Logstash plugin required to be installed on top of the Logstash core pipeline using `logstash-plugin install logstash-filter-base64`. This gem is not a stand-alone program"
  s.authors = ["William Tisäter"]
  s.email = 'william@defunct.cc'
  s.homepage = "http://www.elastic.co/guide/en/logstash/current/index.html"
  s.require_paths = ["lib"]
  s.files = Dir['lib/**/*','spec/**/*','vendor/**/*','*.gemspec','*.md','CONTRIBUTORS','Gemfile','LICENSE','NOTICE.TXT']
  s.test_files = s.files.grep(%r{^(test|spec|features)/})
  s.metadata = { "logstash_plugin" => "true", "logstash_group" => "filter" }

  s.add_runtime_dependency "logstash-core-plugin-api", ">= 1.60", "<= 2.99"

  s.add_development_dependency 'logstash-devutils'
end
