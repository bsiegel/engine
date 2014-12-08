require 'spec_helper'

describe Locomotive::Api::TokensController do

  let!(:account) { create(:account, email: 'john@doe.net') }
  let(:params) do
    {
      "email"     => "john@doe.net",
      "password"  => "easyone"
    }
  end

  before do
    Locomotive.config.stubs(:multi_sites?).returns(false)
  end

  describe 'POST #create' do

    subject { post :create, params.merge(format: :json) }

    context 'valid credentials' do
      it { should be_success }
      it 'returns a token' do
        json_response['token'].should_not be_blank
      end
    end

    context 'invalid credentials' do
      let(:params) { { email: 'dontknow', password: 'same' } }
      its(:status) { should eq 401 }
    end
  end

  describe 'DELETE #destroy' do
    let(:token) do
      response = post(:create, params.merge(format: :json))
      JSON.parse(response.body)['token']
    end

    subject do
      delete :destroy, id: token, locale: :en, format: :json
    end
    it { should be_success }
  end

  def json_response
    JSON.parse(subject.body)
  end

end
