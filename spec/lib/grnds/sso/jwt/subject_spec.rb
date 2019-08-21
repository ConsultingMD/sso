describe Grnds::Sso::Jwt::Subject do
  let(:dummy_jwt) { 'Bearer JWT' }
  let(:jwt_headers) { Hash[Grnds::Sso::Jwt::HEADER, dummy_jwt] }
  let(:jwt_cookies) { Hash[Grnds::Sso::Jwt::COOKIE, dummy_jwt] }

  let :request do
    double(headers: {}, cookies: {})
  end

  shared_examples 'it resolved a jwt' do
    let(:token_type) { }
    let(:uid) { }
    let :token do
      instance_double(Grnds::Auth0::Token, verify!: true, type: token_type, uid: uid)
    end

    before do
      allow(Grnds::Auth0::Token).to receive(:new).and_return(token)
    end

    it 'verifies the token' do
      subject.call(request);
      expect(token).to have_received(:verify!)
    end

    it 'does not resolve a subject' do
      expect(subject.call(request)).to be_nil
    end

    context 'with application token data' do
      let(:token_type) { :application }
      let(:uid) { 12345 }
      let(:result) {
        subject.call(request)
      }

      it 'returns a value object' do
        expect(result).to be_a Grnds::Sso::Jwt::Subject::Value
      end

      it 'correctly identifies the subject' do
        expect(result.type).to eq(token_type)
        expect(result.id).to eq(uid)
      end
    end

    context 'with a user token data' do
      let(:token_type) { :user }
      let(:uid) { 67890 }
      let(:result) {
        subject.call(request)
      }

      it 'returns a value object' do
        expect(result).to be_a Grnds::Sso::Jwt::Subject::Value
      end

      it 'correctly identifies the subject' do
        expect(result.type).to eq(token_type)
        expect(result.id).to eq(uid)
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
