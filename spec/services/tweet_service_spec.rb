require 'spec_helper'

describe TweetService do
  let(:user) { FactoryGirl.create(:user) }
  let(:weight) { 70.0 }
  let(:record) { user.records.build(target_date: Date.new(1999, 12, 31), weight: weight) }
  let(:service) { TweetService.new(user) }

  before :each do
    service.stub(:tweet) { |message| message }
  end

  describe '#daitokaiet_recorded(record)' do
    subject { service.daitokaiet_recorded(record) }
    before :each do
      record.comment = comment
    end

    context 'コメントがある時' do
      let(:comment) { 'がんばった' }
      it { should eq '目標体重まであと10.0kg #daitokaiet がんばった | 1999-12-31 http://daitokaiet.herokuapp.com/social/LuckOfWise' }
    end

    context 'コメントがない時' do
      let(:comment) { nil }
      it { should eq '目標体重まであと10.0kg #daitokaiet | 1999-12-31 http://daitokaiet.herokuapp.com/social/LuckOfWise' }
    end
  end
end
