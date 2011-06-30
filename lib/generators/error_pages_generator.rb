class ErrorPagesGenerator < Rails::Generators::Base
  source_root File.expand_path("../templates", __FILE__)
  
  def copy_error_pages
    copy_file "internal_server_error.html.haml", "app/views/errors/internal_server_error.html.haml"
    copy_file "not_found.html.haml", "app/views/errors/not_found.html.haml"
  end
end