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

    This will create an Errors controller, views and update routing table.

### Manual installation steps

Add to config/application.rb

    config.exceptions_app = self.routes

Create new contoller ErrorsController with following three methods

    class ErrorsController < ApplicationController
      def internal_server_error
      end

      def not_found
      end

      def unprocessable_entity
      end
    end


Create an errors directory under app/views.

Add internal_server_error.html.haml, not_found.html.haml and unprocessable_entity.html.haml with your custom messages.

Add following to routing table

    match "/404", :to => "errors#not_found"
    match "/422", :to => "errors#unprocessable_entity"
    match "/500", :to => "errors#internal_server_error"

Restart your app.

To test in your development environment:

Add to config/environments/development.rb

    config.consider_all_requests_local       = false

Note
-----

Remove 400, 422 and 500 from public directory.

