# -*- coding: utf-8 -*-
require 'spec_helper'

describe User do
  describe '.social_visible' do
    let!(:user) { User.create!(
        goal: 60,
        email: User.create_unique_email,
        password: 'x'*8
    )}

    it '記録がない' do
      expect(User.count).to eq(1)
      expect(User.social_visible.count).to eq(0)
    end

    it '記録がある' do
      record = user.records.build(target_date: Date.today)
      record.stub(:update_twitter)
      record.save!
      expect(User.social_visible.count).to eq(1)
    end
  end
end
