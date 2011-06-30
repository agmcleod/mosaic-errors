class ErrorPagesGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("../templates", __FILE__)
  
  def copy_error_pages
    copy_file "internal_server_error.html.haml", "app/views/layouts/internal_server_error.html.haml"
    copy_file "not_found.html.haml", "app/views/layouts/not_found.html.haml"
  end
end