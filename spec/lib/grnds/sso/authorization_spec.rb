# typed: false
describe Grnds::Sso::Authorization do
  subject do
    Class.new do
      def self.helper_method(method); end
      include Grnds::Sso::Authorization
    end.new
  end

  describe '#authorized_for?' do
    it { expect(subject.authorized_for?(request, %w(admin))).to be(false) }

    context 'with role' do
      it { expect(subject.authorized_for?(request(primary_role: 'cc'), %w(admin))).to be(false) }
      it { expect(subject.authorized_for?(request(primary_role: 'admin'), %w(admin))).to be(false) }

      context 'and user' do
        it { expect(subject.authorized_for?(request(primary_role: 'admin', uid: '1'), %w(admin))).to be(true) }
      end
    end
  end
end
