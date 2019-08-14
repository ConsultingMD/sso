describe Grnds::Sso::Jwt::Uid do
  let(:uid) { 'foobar@a.ca' }
  let(:dummy_jwt) { 'Bearer JWT' }
  let(:jwt_headers) { Hash[Grnds::Sso::Jwt::HEADER, dummy_jwt] }
  let(:jwt_cookies) { Hash[Grnds::Sso::Jwt::COOKIE, dummy_jwt] }
  let(:jwt_payload) { Hash[Grnds::Sso::Jwt::UID_CLAIM, uid] }

  let :request do
    double(headers: {}, cookies: {})
  end

  let :token do
    instance_double(Grnds::Auth0::Token, verify!: true, payload: jwt_payload)
  end

  before do
    allow(Grnds::Auth0::Token).to receive(:new).and_return(token)
  end

  describe '#call' do
    it { expect(subject.call(request)).to be_nil }

    context 'with a jwt in the request header' do
      before do
        allow(request).to receive(:headers).and_return(jwt_headers)
      end

      it 'verifies the token' do
        subject.call(request);
        expect(token).to have_received(:verify!)
      end

      it { expect(subject.call(request)).to eq(uid) }
    end

    context 'with a jwt set as a cookie' do
      before do
        allow(request).to receive(:cookies).and_return(jwt_cookies)
      end

      it 'verifies the token' do
        subject.call(request);
        expect(token).to have_received(:verify!)
      end

      it { expect(subject.call(request)).to eq(uid) }
    end
  end
end
