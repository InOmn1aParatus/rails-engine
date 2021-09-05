require 'rails_helper'

RSpec.describe Item, type: :model do
  # describe 'validations' do
  #   it { should validate_presence_of :}
  # end

  describe 'relationships' do
    it {should belong_to :merchant}
  end

  # describe 'instance methods' do
  # end
end