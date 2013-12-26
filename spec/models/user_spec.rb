require 'spec_helper'

describe User do
  describe '#update_first_step!' do
    context 'step was 0' do
      context 'goal was nil' do
        let(:user) { FactoryGirl.create(:user,:goal => nil) }
        it{user.update_first_step!.should be_false}
      end
      context 'goal was not nil' do
        let(:user) { FactoryGirl.create(:user) }
        it{user.update_first_step!.should be_true}
      end
    end
    context 'step was 1' do
      let(:user) { FactoryGirl.create(:user, :step => 1) }
      it{user.update_first_step!.should be_false}
    end
  end
end
