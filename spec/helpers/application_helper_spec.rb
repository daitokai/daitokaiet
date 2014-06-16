require 'spec_helper'


describe ApplicationHelper, type: :helper do
  describe '#show_weight' do
    subject { helper.show_weight weight }
    let(:weight) { 10 }
    it { is_expected.to eq("10.00") }
  end
end
