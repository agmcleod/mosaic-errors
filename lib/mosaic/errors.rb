module Mosaic
  module Errors
    @@include_stack_trace = false

    def self.include_stack_trace!
      @@include_stack_trace = true
    end

    def self.included(controller)
      controller.extend(ClassMethods)
      controller.rescue_from Exception do |exception|
       render_application_error_template_for_exception(exception)
       Rails.logger.error exception.backtrace.join("\n") if include_stack_trace?
      end
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
        render :template => "errors/#{status}", :status => status
      rescue ActionView::MissingTemplate
        render :nothing => true, :status => status
      end

      def render_application_error_template_for_exception(exception)
        status = self.class.rescue_responses[exception.class.name]
        send_exception_notification(exception) if status == :internal_server_error || status == :not_found
        render_application_error_template status
      end

      def send_exception_notification(exception)
        if defined? notify_airbrake
          notify_airbrake(exception)
        elsif defined? notify_hoptoad
          notify_hoptoad(exception)
        end
      end

      def include_stack_trace?
        @@include_stack_trace
      end
  end
end
