# xcode-pristiene (Work In Progress) [![Build Status](https://travis-ci.org/sgleadow/xcode-pristine.svg?branch=master)](https://travis-ci.org/sgleadow/xcode-pristine)

A gem to help keep your Xcode project file pristine.

When you're using `xcconfig` files to manage your Xcode build settings, you don't want those build settings being overridded inside the Xcode project files build settings editor. This gem used the [xcodeproj gem](https://github.com/CocoaPods/Xcodeproj) from cocoapods, to inspect the build settings in the project file and ensure they're empty.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'xcode-pristine'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install xcode-pristine

## Usage

To ensure your project file is free of unwanted build settings, simply run:

    $ xcpristine

By default, it finds any  `.xcodeproj` files in the current directory and inspects _all build configurations_ and _all targets_.

There may be situations where you want to only inspect _some project files_ or _not all of the configurations or targets for a project_. If that's the case, raise an issue and let's discuss how to add it, I haven't found a need for that yet, as either your project is using xcconfig files or it isn't.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sgleadow/xcode-pristine.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
