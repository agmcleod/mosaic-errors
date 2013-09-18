class ErrorsGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates/', __FILE__)

  def setup
    route "match '/404', :to => 'errors#not_found'"
    route "match '/422', :to => 'errors#unprocessable_entity'"
    route "match '/500', :to => 'errors#internal_server_error'"

    application "config.exceptions_app = self.routes"

    copy_file 'controllers/errors_controller.rb', 'app/controllers/errors_controller.rb'
    directory 'views/errors', 'app/views/errors'
    copy_file 'initializer.rb', 'config/initializers/mosaic-errors.rb'
    directory 'locales', 'config/locales/errors'
  end
end
