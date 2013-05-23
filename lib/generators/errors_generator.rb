class ErrorsGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)
  desc "adds entry to routing table and update application.rb"

  def add_route
    route "mount Mosaic::Errors::Engine => '/'"
  end

  def setup_application
    application "config.exceptions_app = self.routes"
  end
end
