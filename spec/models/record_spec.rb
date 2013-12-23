require 'spec_helper'

describe Record do
  let(:record) do
    user.records.create!(
      comment: comment,
      weight: 58,
      target_date: Date.new(2013, 12,25),
    )
  end

  let(:user) do
    user = User.create(
      name: '大都会',
      email: User.create_unique_email,
      password: Devise.friendly_token[0, 20],
      uid: 'daitokai',
      provider: 'tweet',
    )
    user
  end

  let(:twitter_client) { double().stub(:update) }

  before :each do
    Twitter::REST::Client.stub(:new) { twitter_client }
  end

  describe '#recorded_tweet' do
    context 'コメントがある時' do
      subject { record.recorded_tweet }
      let(:comment) { 'がんばった' }
      it { should eq '目標体重まであと-2.0kg #daitokaiet がんばった | 2013-12-25' }
    end

    context 'コメントがない時' do
      subject { record.recorded_tweet }
      let(:comment) { nil }
      it { should eq '目標体重まであと-2.0kg #daitokaiet | 2013-12-25' }
    end
  end
end
