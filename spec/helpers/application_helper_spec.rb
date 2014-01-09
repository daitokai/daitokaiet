require 'spec_helper'


describe ApplicationHelper do
  describe '#show_weight' do
    subject { helper.show_weight weight }
    let(:weight) { 10 }
    it { should eq("10.00") }
  end
end
