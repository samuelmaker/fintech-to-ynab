class ApplicationController < ActionController::API
  before_action :verify_token, except: [:home, :ping]

  def home
    redirect_to 'https://github.com/syncforynab/fintech-to-ynab'
  end

  def ping
    render json: { pong: true }
  end

  private

  def verify_token
    expected = ENV['URL_SECRET']
    provided = params[:secret]
    unless expected.present? && provided.is_a?(String) &&
        ActiveSupport::SecurityUtils.secure_compare(expected, provided)
      render json: { error: :unauthorised }, status: 401
    end
  end
end
