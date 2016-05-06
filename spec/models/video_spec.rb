require 'spec_helper'

describe Video do
  before { @video = FactoryGirl.build :video }
  subject { @video }

  it { should respond_to(:identifier) }
  it { should respond_to(:published_at) }
  it { should respond_to(:channel_id) }
  it { should respond_to(:title) }
  it { should respond_to(:description) }
  it { should respond_to(:thumbnail) }
  it { should respond_to(:channel_title) }
  it { should respond_to(:category_id) }

  it { should validate_presence_of :identifier }
  it { should validate_uniqueness_of :identifier }
  it { should validate_presence_of :published_at }
  it { should validate_presence_of :channel_id }
  it { should validate_presence_of :title }
  it { should validate_presence_of :description }
  it { should validate_presence_of :thumbnail }
  it { should validate_presence_of :channel_title }
  it { should validate_presence_of :category_id }

  it { should have_many(:tags) }
  it { should have_many(:board_videos) }
  it { should have_many(:boards).through(:board_videos) }

  describe '#tags association' do
    before do
      @video.save
      3.times { FactoryGirl.create :tag, video: @video }
    end

    it 'destroys the associated tags when nuking videos' do
      tags = @video.tags
      @video.destroy
      tags.each do |tag|
        expect(Tag.find(tag)).to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end
