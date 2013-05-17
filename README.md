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

### Auto Install

Use the generator to copy the error files over and add the route to catch all routing errors:

    rails generator mosaic_errors
  
Add to ApplicationController:

    include Mosaic::Errors
  
Ensure the provided route goes very last in your config/routes.rb file as it will catch anything that is not previously configured
  
### Manual Install

Add to config/routes.rb:

    match '*path', :to => 'application#routing_error'
  
Ensure the above route comes very last in your config/routes.rb file as it will catch anything that is not previously configured.

Create the folder app/views/errors and drop the files internal_server_error.html.haml & not_found.html.haml
  
Add to ApplicationController:

    include Mosaic::Errors

Configuration
-------------

By default this gem will not display a stacktrace when something goes wrong. This can potentially be problematic when debugging an application so this behaviour can be overridden by adding the following to an initializer:

    Mosaic::Errors.include_stack_trace!
