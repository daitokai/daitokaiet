require 'spec_helper'

describe Record do
  let(:user) { FactoryGirl.create(:user) }
  let(:weight) { 70.0 }
  let(:record) { user.records.build(target_date: Date.new(1999, 12, 31), weight: weight) }
  before do
    Record.skip_callback(:save, :after, :update_twitter)
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

  before :each do
    Twitter::REST::Client.stub(:new) { twitter_client }
  end

  describe '#recorded_tweet' do
    before :each do
      record.comment = comment
    end

    context 'コメントがある時' do
      subject { record.recorded_tweet }
      let(:comment) { 'がんばった' }
      it { should eq '目標体重まであと10.0kg #daitokaiet がんばった | 1999-12-31' }
    end

    context 'コメントがない時' do
      subject { record.recorded_tweet }
      let(:comment) { nil }
      it { should eq '目標体重まであと10.0kg #daitokaiet | 1999-12-31' }
    end
  end
end
