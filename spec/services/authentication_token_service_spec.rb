require 'rails_helper'

describe AuthenticationTokenService do
  describe '.call' do
    let(:token) { described_class.call }

    it 'returns an authentication token' do
      decoded_token = JWT.decode token,
                                 Rails.application.credentials.hmac_secret,
                                 true,
                                 { algorithm: Rails.application.credentials.algorithm_type }

      expect(decoded_token).to eq([
                                    { 'test' => 'blah' },
                                    { 'alg' => 'HS256' }
                                  ])
    end
  end
end
