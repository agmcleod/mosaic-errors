module Mosaic
  module Errors
    def self.included(controller)
      controller.extend(ClassMethods)
      controller.rescue_from Exception, :with => :render_application_error_template_for_exception
    end

    def routing_error
      render_application_error_template :not_found
    end

    module ClassMethods
      DEFAULT_RESCUE_RESPONSE = :internal_server_error

      DEFAULT_RESCUE_RESPONSES = {
        'ActionController::RoutingError'             => :not_found,
        'ActionController::UnknownAction'            => :not_found,
        'ActiveRecord::RecordNotFound'               => :not_found,
        'ActiveRecord::StaleObjectError'             => :conflict,
        'ActiveRecord::RecordInvalid'                => :unprocessable_entity,
        'ActiveRecord::RecordNotSaved'               => :unprocessable_entity,
        'ActionController::MethodNotAllowed'         => :method_not_allowed,
        'ActionController::NotImplemented'           => :not_implemented,
        'ActionController::InvalidAuthenticityToken' => :unprocessable_entity
      }

      def rescue_responses
        @rescue_responses ||= Hash.new(DEFAULT_RESCUE_RESPONSE).merge(DEFAULT_RESCUE_RESPONSES)
      end
    end

    protected
      def render_application_error_template(status)
        Rails.logger.debug ">>>>>>>>>>>>>>>>>>>>>> #{status}"
        render :template => "errors/#{status}", :status => status
      rescue ActionView::MissingTemplate
        render :nothing => true, :status => status
      end

      def render_application_error_template_for_exception(exception)
        status = self.class.rescue_responses[exception.class.name]
        notify_hoptoad(exception) if status == :internal_server_error
        render_application_error_template status
      end
  end
end
