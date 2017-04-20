The Ruby version of this sample uses RSpec.

The tests are in `spec/checkout_spec.rb` and the stub implementation is in
`lib/checkout.rb`.

There is a Gemfile to download any dependencies with a `bundle install`. You
can run the tests with the rather familiar `bundle exec rspec`.

There also binstubs installed, so you can use `bin/rspec`. If you have direnv
installed and allow this directory, `bin` will be on your path and you can run
`rspec` directly.

If you would like to autorun tests, Guard is configured. You can run it in the
same ways as RSpec, that is, `bundle exec guard`, `bin/guard`, or `guard` with
direnv.

If you need to set up your environment, the Go Rails instructions are a good
place to start:

https://gorails.com/setup

