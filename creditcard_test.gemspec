Gem::Specification.new do |spec|
  spec.name        = 'creditcard_test'
  spec.version     = '1.0.0'
  spec.summary     = 'Credit card test'
  spec.description = 'Ruby credit card test for Everyday Hero'
  spec.authors     = ['Peter Klein']
  spec.email       = 'squizz.klein@gmail.com'
  spec.files       = `git ls-files -z`.split("\x0")
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
end
