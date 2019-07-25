describe Grnds::Sso::AuthorizationConstraint do
  subject { described_class.new(%w(admin cc)) }

  describe '#authenticated?' do
    it { expect(subject.authenticated?(request)).to be(false) }

    context 'with a user' do
      it { expect(subject.authenticated?(request(uid: 1))).to be(true) }
    end
  end

  describe '#authorized?' do
    it { expect(subject.authorized?(request)).to be(false) }

    context 'with invalid role' do
      it { expect(subject.authorized?(request(primary_role: 'member'))).to be(false) }
    end

    context 'with invalid role' do
      it { expect(subject.authorized?(request(primary_role: 'cc'))).to be(true) }
    end
  end
end
