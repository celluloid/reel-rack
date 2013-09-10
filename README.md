Reel::Rack
==========

[![Build Status](https://secure.travis-ci.org/celluloid/reel-rack.png?branch=master)](http://travis-ci.org/celluloid/reel-rack)
[![Code Climate](https://codeclimate.com/github/celluloid/reel-rack.png)](https://codeclimate.com/github/celluloid/reel-rack)
[![Coverage Status](https://coveralls.io/repos/celluloid/reel-rack/badge.png?branch=master)](https://coveralls.io/r/celluloid/reel-rack)

A Rack adapter for [Reel][reel], the [Celluloid::IO][celluloidio] web server.

[reel]: https://github.com/celluloid/reel
[celluloidio]: https://github.com/celluloid/celluloid-io

## Installation

reel-rack can be installed with RubyGems:

    gem install reel-rack

Bundle it with your application by adding this to your Gemfile:

    gem 'reel-rack'

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

Copyright (c) 2013 Tony Arcieri, Jonathan Stott.
Distributed under the MIT License. See LICENSE.txt for further details.
