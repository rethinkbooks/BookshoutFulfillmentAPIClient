require_relative 'lib/bookshout_api/version'

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'bookshout_fulfillment_api'
  s.version     = Bookshout::API::VERSION
  s.summary     = 'BookShout fulfillment API client'
  s.description = 'BookShout fulfillment API client'

  s.required_ruby_version = '>= 2.1.0'

  s.license = 'MIT'

  s.authors  = ['Peter Jacobs']
  s.email    = ['peter@bookshout.com']
  s.homepage = 'https://github.com/rethinkbooks/BookshoutFulfillmentAPIClient'

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if s.respond_to?(:metadata)
    s.metadata['allowed_push_host'] = 'none'
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  s.files        = Dir['README.md', 'lib/**/*']
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_development_dependency 'bundler', '~> 1.0'
  s.add_development_dependency 'rake', '~> 10.0'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'simplecov'

  s.add_runtime_dependency 'rest-client'
end
