require 'spec_helper'

describe Api::V1::BoardsController do
  before(:each) { request.headers['Accept'] = 'application/vnd.pintube.v1' }

  describe 'GET #show' do
    before(:each) do
      @board = FactoryGirl.create(:board)
      get :show, id: @board.id, format: :json
    end

    it 'returns the information of a specific board on a hash' do
      board_response = JSON.parse(response.body, symbolize_names: true)
      expect(board_response[:name]).to eql @board.name
    end

    it { should respond_with 200 }
  end

  describe 'POST #create' do
    context 'when a board is successfully created' do
      before(:each) do
        @board_attributes = FactoryGirl.attributes_for :board
        post :create, { board: @board_attributes }, format: :json
      end

      it 'returns the JSON representation of the newly created board' do
        board_response = JSON.parse(response.body, symbolize_names: true)
        expect(board_response[:name]).to eql @board_attributes[:name]
      end

      it { should respond_with 201 }
    end

    context 'when a board is unsuccessfully created' do
      before(:each) do
        @invalid_board_attributes = { description: 'Hipsters ipsum wada wada' }
        post :create, { board: @invalid_board_attributes }, format: :json
      end

      it 'renders an error' do
        board_response = JSON.parse(response.body, symbolize_names: true)
        expect(board_response).to have_key(:errors)
      end

      it 'returns the JSON error on why the board could not be created' do
        board_response = JSON.parse(response.body, symbolize_names: true)
        expect(board_response[:errors][:name]).to include 'can\'t be blank'
      end

      it { should respond_with 422 }
    end
  end

  describe 'PUT/PATCH #update' do
    context 'when is successfully updated' do
      before(:each) do
        @board = FactoryGirl.create :board
        put :update, { id: @board.id,
                         board: { name: "Psychedelic Madness" } }, format: :json 
      end

      it 'returns the JSON representation of the updated board' do
        board_response = JSON.parse(response.body, symbolize_names: true)
        expect(board_response[:name]).to eql 'Psychedelic Madness'
      end

      it { should respond_with 200 }
    end

    context 'when it is not successfully updated' do
      before(:each) do
        @board = FactoryGirl.create :board
        put :update, { id: @board.id,
                         board: { name: '' } }, format: :json
      end

      it 'returns an error' do
        board_response = JSON.parse(response.body, symbolize_names: true)
        expect(board_response).to have_key(:errors)
      end

      it 'returns the JSON error why the board cannot be updated' do
        board_response = JSON.parse(response.body, symbolize_names: true)
        expect(board_response[:errors][:name]).to include 'can\'t be blank'
      end

      it { should respond_with 422 }
    end
  end
end
