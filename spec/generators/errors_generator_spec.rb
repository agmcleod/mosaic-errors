require 'spec_helper'

describe ErrorsGenerator do
  let(:generator) { ErrorsGenerator.new(["errors"]) }
  before do
    generator.stub :route
    generator.stub :application
    generator.stub :copy_file
    generator.stub :directory
    Rails::Generators.stub(:options => {
      :rails => {
        :template_engine => :erb
      }
    })
  end
  describe "#setup" do
    describe "routes" do
      it "404" do
        generator.should_receive(:route).with("match '/404', :to => 'errors#not_found'")
        generator.setup
      end

      it "422" do
        generator.should_receive(:route).with("match '/422', :to => 'errors#unprocessable_entity'")
        generator.setup
      end

      it "500" do
        generator.should_receive(:route).with("match '/500', :to => 'errors#internal_server_error'")
        generator.setup
      end
    end

    describe "application setup" do
      it "should tell rails to use its router for exception pages" do
        generator.should_receive(:application).with("config.exceptions_app = self.routes")
        generator.setup
      end
    end

    describe "files" do
      describe "views" do
        context "erb" do
          it "internal server error" do
            generator.should_receive(:copy_file).with("views/errors/internal_server_error.html.erb", "app/views/errors/internal_server_error.html.erb")
            generator.setup
          end

          it "not found" do
            generator.should_receive(:copy_file).with("views/errors/not_found.html.erb", "app/views/errors/not_found.html.erb")
            generator.setup
          end

          it "unprocessable entity" do
            generator.should_receive(:copy_file).with("views/errors/unprocessable_entity.html.erb", "app/views/errors/unprocessable_entity.html.erb")
            generator.setup
          end
        end

        context "haml" do
          before do
            Rails::Generators.stub(:options => {
              :rails => {
                :template_engine => :haml
              }
            })
          end

          it "internal server error" do
            generator.should_receive(:copy_file).with("views/errors/internal_server_error.html.haml", "app/views/errors/internal_server_error.html.haml")
            generator.setup
          end

          it "not found" do
            generator.should_receive(:copy_file).with("views/errors/not_found.html.haml", "app/views/errors/not_found.html.haml")
            generator.setup
          end

          it "unprocessable entity" do
            generator.should_receive(:copy_file).with("views/errors/unprocessable_entity.html.haml", "app/views/errors/unprocessable_entity.html.haml")
            generator.setup
          end
        end
      end

      describe "other" do
        it "errors controller should be copied" do
          generator.should_receive(:copy_file).with('controllers/errors_controller.rb', 'app/controllers/errors_controller.rb')
          generator.setup
        end

        it "initializer should be copied over, populating the i18n path" do
          generator.should_receive(:copy_file).with('initializer.rb', 'config/initializers/mosaic-errors.rb')
          generator.setup
        end

        it "directory of locale files should be copied" do
          generator.should_receive(:directory).with('locales', 'config/locales/errors')
          generator.setup
        end
      end
    end
  end
end