class ErrorsGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates/', __FILE__)

  def setup
    route "/404", :to => "errors#not_found"
    route "/422", :to => "errors#unprocessable_entity"
    route "/500", :to => "errors#internal_server_error"

    application "config.exceptions_app = self.routes"

    copy_file 'controllers/errors_controller.rb', 'app/controllers/errors_controller.rb'
    directory 'views/errors', 'app/views/errors'
  end
end
