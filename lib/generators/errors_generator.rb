class ErrorsGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates/', __FILE__)

  def setup
    route "match '/404', :to => 'errors#not_found'"
    route "match '/422', :to => 'errors#unprocessable_entity'"
    route "match '/500', :to => 'errors#internal_server_error'"

    application "config.exceptions_app = self.routes"

    copy_file 'controllers/errors_controller.rb', 'app/controllers/errors_controller.rb'
    file_type = 'erb'
    begin
      if Haml
        file_type = 'haml'
      end
    rescue NameError
    end
    copy_file "views/errors/internal_server_error.html.#{file_type}", "app/views/errors/internal_server_error.html.#{file_type}"
    copy_file "views/errors/not_found.html.#{file_type}", "app/views/errors/not_found.html.#{file_type}"
    copy_file "views/errors/unprocessable_entity.html.#{file_type}", "app/views/errors/unprocessable_entity.html.#{file_type}"
  end
end
