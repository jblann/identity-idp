require 'rails_helper'

describe MfaPolicy do
  let(:subject) { described_class.new(user) }

  context 'no mfa configurations' do
    let(:user) { create(:user) }

    it { expect(subject.two_factor_enabled?).to eq false }
    it { expect(subject.multiple_factors_enabled?).to eq false }
  end

  context 'one mfa configuration' do
    let(:user) { create(:user, :with_phone) }

    it { expect(subject.two_factor_enabled?).to eq true }
    it { expect(subject.multiple_factors_enabled?).to eq false }
  end

  context 'two mfa configuration' do
    let(:user) { create(:user, :with_phone, :with_piv_or_cac) }

    it { expect(subject.two_factor_enabled?).to eq true }
    it { expect(subject.multiple_factors_enabled?).to eq true }
  end
end
