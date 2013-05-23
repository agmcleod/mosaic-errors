class ErrorsGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  def setup
    route "mount Mosaic::Errors::Engine => '/'"
    application "config.exceptions_app = self.routes"
  end
end
