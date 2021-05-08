class AuthenticationTokenService
  # HMAC_SECRET = 'my$ecretK3y'.freeze
  # ALGORITHM_TYPE = 'HS256'.freeze

  def self.call(user_id)
    payload = { user_id: user_id }
    JWT.encode payload, Rails.application.credentials.hmac_secret, Rails.application.credentials.algorithm_type
  end
end
