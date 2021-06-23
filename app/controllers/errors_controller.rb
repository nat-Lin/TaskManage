class ErrorsController < ApplicationController
  skip_before_action :authorize
  before_action :set_error_message_icon

  def not_found
    render status: 404
  end

  def unacceptable
    render status: 422
  end

  def internal_server_error
    render status: 500
  end

  private

    def set_error_message_icon
      icon = {
        not_found: 'fa-exclamation-triangle',
        unacceptable: 'fa-keyboard',
        internal_server_error: 'fa-tools'
      }
      @error_message = I18n.t("errors.#{action_name}.message")
      @error_icon = icon[action_name.to_sym]
    end
end