describe Grnds::Sso::Jwt::Subject do
  let(:grant_type) { 'client-credentials' }
  let(:uid) { 'foobar@a.ca' }
  let(:dummy_jwt) { 'Bearer JWT' }
  let(:jwt_headers) { Hash[Grnds::Sso::Jwt::HEADER, dummy_jwt] }
  let(:jwt_cookies) { Hash[Grnds::Sso::Jwt::COOKIE, dummy_jwt] }
  let(:jwt_payload) do
    value = {}
    value[Grnds::Sso::Jwt::Subject::UID_CLAIM] = uid
    value[Grnds::Sso::Jwt::Subject::GRANT_TYPE_CLAIM] = grant_type
    value
  end

  let :request do
    double(headers: {}, cookies: {})
  end

  let :token do
    instance_double(Grnds::Auth0::Token, verify!: true, payload: jwt_payload)
  end

  before do
    allow(Grnds::Auth0::Token).to receive(:new).and_return(token)
  end

  shared_examples 'it resolved a jwt' do
    it 'verifies the token' do
      subject.call(request);
      expect(token).to have_received(:verify!)
    end

    it { expect(subject.call(request).id ).to eq(uid) }

    context 'without a uid claim' do
      let(:jwt_payload) { Hash[Grnds::Sso::Jwt::Subject::GRANT_TYPE_CLAIM, grant_type] }

      it { expect(subject.call(request)).to be_nil }
    end

    context 'as a client-credential grant' do
      it 'identifies the subject as an application' do
        expect(subject.call(request).type).to eq(:application)
      end
    end

    context 'as a password grant' do
      let(:grant_type) { 'password' }

      it 'identifies the subject as a user' do
        expect(subject.call(request).type).to eq(:user)
      end
    end
  end

  describe '.call' do
    it { expect(subject.call(request)).to be_nil }

    context 'with a jwt in the request header' do
      before do
        allow(request).to receive(:headers).and_return(jwt_headers)
      end

      it_behaves_like 'it resolved a jwt'
    end

    context 'with a jwt set as a cookie' do
      before do
        allow(request).to receive(:cookies).and_return(jwt_cookies)
      end

      it_behaves_like 'it resolved a jwt'
    end

  end
end
