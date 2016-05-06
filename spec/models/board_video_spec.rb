require 'spec_helper'

describe BoardVideo do
  let(:board_video) { FactoryGirl.build :board_video }
  subject { board_video }

  it { should respond_to(:board_id) }
  it { should respond_to(:video_id) }

  it { should validate_presence_of(:board_id) }
  it { should validate_presence_of(:video_id) }

  it { should belong_to(:board) }
  it { should belong_to(:video) }
end
