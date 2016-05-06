require 'spec_helper'

describe Tag do
  let(:tag) { FactoryGirl.build :tag }
  subject { tag }

  it { should respond_to(:name) }
  it { should respond_to(:video_id) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:video_id) }

  it { should belong_to :video }
end
