require 'spec_helper'

describe Board do
  describe Board do
    before { @board = FactoryGirl.build(:board) }

    subject { @board }

    # Attribute tests
    it { should respond_to(:name) }
    it { should respond_to(:description) }

    # Validation tests
    it { should be_valid }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_uniqueness_of(:name) }

    it { should have_many(:board_videos) }
    it { should have_many(:videos).through(:board_videos) }
  end
end
