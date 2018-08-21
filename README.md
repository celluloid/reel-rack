![Reel::Rack](https://github.com/celluloid/reel-rack/raw/master/logo.png)
==========
[![Gem Version](https://badge.fury.io/rb/reel-rack.svg)](http://rubygems.org/gems/reel-rack)
 [![MIT licensed](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/celluloid/reel-rack/blob/master/LICENSE.txt)
[![Build Status](https://secure.travis-ci.org/celluloid/reel-rack.svg?branch=master)](http://travis-ci.org/celluloid/reel-rack)
[![Maintained: no](https://img.shields.io/maintenance/no/2016.svg)](https://github.com/celluloid/celluloid/issues/779)

A Rack adapter for [Reel][reel], the [Celluloid::IO][celluloidio] web server.

[reel]: https://github.com/celluloid/reel
[celluloidio]: https://github.com/celluloid/celluloid-io

## Installation

reel-rack can be installed with RubyGems:

    gem install reel-rack

Bundle it with your application by adding this to your Gemfile:

    gem 'reel-rack'

## Documentation

Please see the [Reel::Rack Wiki][wiki] for detailed documentation, including
how to use Reel::Rack with the [Ruby on Rails][rails] web framework.

More information about Reel itself can be found on the [Reel Project Page][reel]

[wiki]:  https://github.com/celluloid/reel-rack/wiki
[rails]: http://rubyonrails.org/
[reel]:  https://github.com/celluloid/reel

## Usage

You should be able to launch any Rack-compatible under Reel with:

    reel-rack

By default reel-rack will launch on port 3000. You can specify a port with:

    reel-rack -p 9001

By default reel-rack will look for a config.ru file. You can specify any name
you want, though:

    reel-rack my_awesome_app.rb

For additional help, run:

    reel-rack -h

## Contributing

* Fork this repository on Github
* Make your changes and send a pull request
* If your changes look good, we'll merge 'em

## License

Copyright (c) 2013-2016 Tony Arcieri, Jonathan Stott.
Distributed under the MIT License. See LICENSE.txt for further details.
