# resque-async\_deliver

[![Build Status][build-image]][build-link]
[![Gem Version][gem-image]][gem-link]
[![Dependency Status][deps-image]][deps-link]
[![Code Climate][gpa-image]][gpa-link]
[![Bitdeli Badge][stats-image]][stats-link]

resque-async\_deliver is a simple gem to send emails asynchronously
using [Resque](https://github.com/defunkt/resque) without having to
change much in your existing codebase.

## Installing

In your Gemfile:

```ruby
gem 'resque-async_deliver'
```

## Usage

Whenever you want to asynchronously send an email, simply change

```ruby
SomeMailer.some_mail(an_argument, another_argument).deliver
```

to this

```ruby
SomeMailer.async_deliver.some_mail(an_argument, another_argument)
```

This will enqueue a job that will simply run

```ruby
SomeMailer.some_mail(an_argument, another_argument).deliver
```

You don't have to change your mailers, even if they take ActiveRecord
objects as arguments. Since all the arguments will be JSON encoded
by Resque before storing them in Redis, ActiveRecord objects will be
serialized as a hash containing the class and the id of the model.
resque-async\_deliver will then `find` the records and pass them to the
mailer.

The jobs will be added to Resque in the `mail` queue.

## Details

Tested on ruby 1.8.7 and 1.9.2.

## Contributing

1. Fork
2. Create a topic branch
3. Push to your branch
4. Send a pull request

## Author

Philipe Fatio  
<philipe.fatio@gmail.com>  
[@fphilipe](http://twitter.com/fphilipe)

[build-image]: https://travis-ci.org/fphilipe/resque-async_deliver.png
[build-link]:  https://travis-ci.org/fphilipe/resque-async_deliver
[gem-image]:   https://badge.fury.io/rb/resque-async_deliver.png
[gem-link]:    https://rubygems.org/gems/resque-async_deliver
[deps-image]:  https://gemnasium.com/fphilipe/resque-async_deliver.png
[deps-link]:   https://gemnasium.com/fphilipe/resque-async_deliver
[gpa-image]:   https://codeclimate.com/github/fphilipe/resque-async_deliver.png
[gpa-link]:    https://codeclimate.com/github/fphilipe/resque-async_deliver
[stats-image]: https://d2weczhvl823v0.cloudfront.net/fphilipe/resque-async_deliver/trend.png
[stats-link]:  https://bitdeli.com/
