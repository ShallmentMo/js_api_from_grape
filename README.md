# JsApiFromGrape

I just have an idea that we can generate js API library from [grape](https://github.com/ruby-grape/grape), so at least we don't need to validate the params.
This repo is just for this idea.

## Problem and Warning

* I use [url-pattern](https://github.com/snd/url-pattern) to test whether the path can be used or not. But I'm not sure `url-pattern` can test all path we use in `grape`. If not, I might write some test refer to [mustermann19](https://github.com/namusyaka/mustermann19).
* I use `Promise` and `fetch` API. This work for me in Chrome, but it should have compatibility problem. Might use babel-polyfill.
* Still need to do the validator and the usage.
* *Not ready for production*

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'js_api_from_grape'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install js_api_from_grape

## Usage

I guess you will just add a method like `add_js_api`. Then it might use an api to return the js, or might generate the js file which you can use in Rails.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ShallmentMo/js_api_from_grape. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

