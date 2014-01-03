# coding: UTF-8

$:.push File.expand_path("../lib", __FILE__)
require "resque/plugins/async_deliver/version"

Gem::Specification.new do |s|
  s.name        = "resque-async_deliver"
  s.version     = Resque::Plugins::AsyncDeliver::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Philipe Fatio"]
  s.email       = ["philipe.fatio@gmail.com"]
  s.homepage    = "https://github.com/fphilipe/resque-async_deliver"
  s.summary     = %q{Deliver mails asynchronously using Resque without explicitly creating a performable job.}
  s.description = <<-description
This gem makes it possible to send mails asynchronously using Resque by
simply rewriting `SomeMailer.some_mail(ar_resource, 1234).deliver` to
`SomeMailer.async_deliver.some_mail(ar_resource, 1234)`. Using ActiveRecord
objects as arguments to mailers is still possible. This is achieved by storing
the class name and the record id as arguments in the Resque queue which will be
transformed back to records by the mailer job and passed along to the mailer.
                  description

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'resque'      , '~> 1.0'
  s.add_dependency 'actionmailer', '~> 3.0'

  s.add_development_dependency 'rspec-core'
  s.add_development_dependency 'rspec-expectations'
  s.add_development_dependency 'mocha'
end
