describe Grnds::Sso::Authentication do
  subject do
    Class.new do
      def session; end
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
    it do
      subject.authenticate_user
    end
  end
end
