require 'spec_helper'

describe User, type: :model do
  describe '#update_first_step!' do
    context 'step was 0' do
      context 'goal was nil' do
        let(:user) { FactoryGirl.create(:user,:goal => nil) }
        it{expect(user.update_first_step!).to be_falsey}
      end
      context 'goal was not nil' do
        let(:user) { FactoryGirl.create(:user) }
        it{expect(user.update_first_step!).to be_truthy}
      end
    end
    context 'step was 1' do
      let(:user) { FactoryGirl.create(:user, :step => 1) }
      it{expect(user.update_first_step!).to be_falsey}
    end
  end
end
