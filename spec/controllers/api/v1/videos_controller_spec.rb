require 'spec_helper'

describe Api::V1::VideosController do
  describe 'GET #show' do
    before(:each) do
      @video = FactoryGirl.create :video
      get :show, id: @video.id
    end

    it 'returns the video information in JSON format' do
      expect(json_response[:video][:title]).to eql @video.title
    end

    it { should respond_with 200 }
  end

  describe 'GET #index' do
    before(:each) do
      5.times { FactoryGirl.create :video }
      get :index
    end

    it 'returns 5 records from the database' do
      expect(json_response[:videos].size).to eq(5)
    end

    it { should respond_with 200 }
  end
end
