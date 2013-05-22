mosaic-errors
=============

Gem to add custom error pages to your rails 3 app.

Installation
------------

Add to Gemfile:

    gem 'mosaic-errors'

Then...

    bundle install

Usage
-----

### Installation steps

Add to ApplicationController:

    include Mosaic::Errors

Add to config/routes.rb:

    mount Errors::Engine => "/"

Add to config/application.rb

    config.exceptions_app = self.routes

Restart your app.