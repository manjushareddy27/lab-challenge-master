require 'rails_helper'

describe ApiKey, type: :model do
  let(:secret) { '10ae820f-8c24-4e69-888b-03cbc36c89a6' }
  it 'should store Api secret key' do
    expect(ApiKey::SECRET).to eq(secret)
  end

  describe '#can_access?' do
    subject(:request) { ApiKey.can_access?(api_key) }

    context 'when valid secret key passed' do
      let(:api_key) { secret }
      it 'should return true' do
        expect(request).to be(true)
      end
    end

    context 'when invalid secret key passed' do
      let(:api_key) { '1243d3' }
      it 'should return false' do
        expect(request).to be(false)
      end
    end
  end
end
