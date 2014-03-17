require 'spec_helper'

describe Record do
  let(:user) { FactoryGirl.create(:user) }
  let(:weight) { 70.0 }
  let(:record) { user.records.build(target_date: Date.new(1999, 12, 31), weight: weight) }

  describe '.liner_interpolate' do
    subject { Record.liner_interpolate(start_x, start_y, end_x, end_y, x) }
    describe 'start: (2013-12-15,10) end: (2013-12-19,11), x: 2013-12-17' do
      let(:start_x) { Date.new(2013, 12, 15) }
      let(:start_y) { 10 }
      let(:end_x) { Date.new(2013, 12, 19) }
      let(:end_y) { 11 }
      let(:x) { Date.new(2013, 12, 17) }
      it { should eq(10.5) }
    end
  end

  describe 'validates' do
    subject { record.valid? }
    context 'when weight is nil' do
      let(:weight) { nil }
      it { expect(subject).to eq(false) }
    end
    context 'when weight is 0' do
      let(:weight) { 0 }
      it { expect(subject).to eq(false) }
    end
    context 'when weight is 57,0' do
      let(:weight) { '57,0' }
      it { expect(subject).to eq(false) }
    end
    context 'when weight is 57' do
      let(:weight) { '57.0' }
      it { expect(subject).to eq(true) }
    end
  end


  describe '#to_goal' do
    subject { record.to_goal }
    context 'goal:60/weight:70' do
      it { expect(subject).to eq(70.0 - 60.0) }
    end
    context 'goal:60/weight:57.44' do
      let(:weight) { 57.44 }
      it { expect(subject).to eq(57.44 - 60.0) }
    end
  end

  describe '#delta' do
    subject(:delta) { record.delta }
    context '該当日より前のデータがない場合' do
      it { expect(delta).to eq nil }
    end
    context '前日のデータがある場合' do
      before do
        user.records.create(target_date: Date.new(1999, 12, 30), weight: 71.0)
      end
      it { expect(delta).to eq -1.0 }
    end
    context '前々日のデータがある場合' do
      before do
        user.records.create(target_date: Date.new(1999, 12, 29), weight: 72.0)
      end
      it { expect(delta).to eq -2.0 }
    end
  end
end
