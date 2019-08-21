describe Grnds::Sso::Authentication do
  subject do
    Class.new do
      def session; end
      def redirect_to(url); end
      def self.helper_method(method); end

      # testing protected methods and everything in this module is protected
      def authenticated?; super; end
      def authenticate_user; super; end

      include Grnds::Sso::Authentication
      include Grnds::Sso::ViewHelpers
    end.new
  end

  before do
    allow(subject).to receive(:session).and_return(OpenStruct.new(session))
    allow(subject).to receive(:redirect_to)
  end

  let(:session) {{}}

  describe '#authenticated?' do
    it { expect(subject).not_to be_authenticated }

    context 'when uid present in session' do
      let(:session) {{ 'uid'=> 1 }}
      it { expect(subject).to be_authenticated }
    end
  end

  describe '#authenticate_user' do
    before do
      Grnds::Sso.configure do |config|
        config.base_site = 'http://grnds.com'
        config.sign_in_post_fix = '/login'
      end
    end

    it 'redirects to login page' do
      subject.authenticate_user
      expect(subject).to have_received(:redirect_to).with('http://grnds.com/login?return_to=http%3A%2F%2Ftest.host%2F')
    end

    context 'when authenticated' do
      let(:session) {{ 'uid'=> 1 }}

      it 'doesnt redirect' do
        subject.authenticate_user
        expect(subject).not_to have_received(:redirect_to)
      end
    end

    context 'with a JWT present' do
      let(:jwt_user) {
        Grnds::Sso::Jwt::Subject::Value.new(:user, 'foobar@a.ca')
      }

      before do
        allow(Grnds::Sso::Jwt::Subject).to receive(:call).and_return(jwt_user)
      end

      it 'doesnt redirect' do
        subject.authenticate_user
        expect(subject).not_to have_received(:redirect_to)
      end

      context 'when previously authenticated' do
        let(:session) {{ 'uid'=> 1 }}

        it 'JWT take precedence' do
          subject.authenticate_user
          expect(subject.session['uid']).to eq jwt_user.id
        end
      end
    end
  end
end
