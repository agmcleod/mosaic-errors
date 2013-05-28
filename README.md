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
### Automated installation steps

    rails generate errors setup

    This will create an Errors controller and views.

### Manual installation steps

Add to config/routes.rb:

    mount Mosaic::Errors::Engine => "/"

Add to config/application.rb

    config.exceptions_app = self.routes

Restart your app.

To test in your development environment:

Add to config/environments/development.rb

    config.consider_all_requests_local       = false

Note
-----

Remove 400, 422 and 500 from public directory.

This gem provides default error pages. If you need your application specific errors, then:

  1. Create an errors layout under app/views/layouts.
  2. Create an errors directory under app/views.
  3. Add internal_server_error.html.haml, not_found.html.haml and unprocessable_entity.html.haml with your custom messages.
