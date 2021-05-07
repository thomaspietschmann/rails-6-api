class AuthenticationTokenService
  # HMAC_SECRET = 'my$ecretK3y'.freeze
  # ALGORITHM_TYPE = 'HS256'.freeze

  def self.call
    p Rails.application.credentials.algorithm_type
    p Rails.application.credentials.hmac_secret

    payload = { 'test' => 'blah' }

    token = JWT.encode payload, Rails.application.credentials.hmac_secret, Rails.application.credentials.algorithm_type
  end
end
