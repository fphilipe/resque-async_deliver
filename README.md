# resque-async\_deliver

[![Build Status](https://travis-ci.org/fphilipe/resque-async_deliver.png)](https://travis-ci.org/fphilipe/resque-async_deliver)
[![Gem Version](https://badge.fury.io/rb/resque-async_deliver.png)](http://badge.fury.io/rb/resque-async_deliver)
[![Dependency Status](https://gemnasium.com/fphilipe/resque-async_deliver.png)](https://gemnasium.com/fphilipe/resque-async_deliver)
[![Code Climate](https://codeclimate.com/github/fphilipe/resque-async_deliver.png)](https://codeclimate.com/github/fphilipe/resque-async_deliver)

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
