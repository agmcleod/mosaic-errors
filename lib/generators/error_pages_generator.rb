class ErrorPagesGenerator < Rails::Generators::Base
  desc "adds error pages haml to the application and add routes"
  source_root File.expand_path("../templates", __FILE__)
  
  def copy_error_pages
    copy_file "internal_server_error.html.haml", "app/views/errors/internal_server_error.html.haml"
    copy_file "not_found.html.haml", "app/views/errors/not_found.html.haml"
  end
  
  def add_route
    route "match '*path', :to => 'application#routing_error'"
  end
end