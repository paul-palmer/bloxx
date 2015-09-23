# Bloxx

This gem provides tools for crafting syntactically correct Minecraft client
  commands.

## History

This code started off as an ad-hoc collection of Ruby code to simplify the construction
  of complex client commands needed while constructing Minecraft worlds for my children.
  Eventually, the code because useful enough in its own right, that I thought others might
  find it useful if it were packaged up as a gem. It is currently in the early stages of
  its migration. Test cases are spotty and the documentation is almost non-existent.
 
My hope is that this gem will continue to grow and evolve into a complete system for
 running client-side bots.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bloxx'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bloxx

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

0. Be patient. It isn't ready for collaboration yet.

1. Fork it ( https://github.com/[my-github-username]/bloxx/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## To Do

- [x] Create basic gem scaffolding
- [ ] Create robust specs for testing.
- [ ] Document how to use the current classes
- [ ] Add the tool that translates RTF documents into Minecraft books
- [ ] Add the tool that automates command sequences using falling-sand
- [ ] Add support for the Minecraft protocol
- [ ] Add support for version 1.9 when it is released
