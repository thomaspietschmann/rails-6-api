class ApplicationController < ActionController::Base
  # rescue_from ActiveRecord::RecordNotFound, with: :handle_error
  rescue_from ActiveRecord::RecordNotDestroyed, with: :handle_error

  private

  def handle_error(e)
    render json: { error: e }, status: :unprocessable_entity
  end
end
