require 'rails_helper'

RSpec.describe Api::V1::BooksController, type: :controller do
  describe 'GET index do' do
    it 'has a max limit of 100' do
      expect(Book).to receive(:limit).with(100).and_call_original

      get :index, params: { limit: 999 }
    end
  end

  describe 'POST create' do
    let(:book_title) { 'You and me' }
    it 'calls UpdateSkuJob with correct params' do
      expect(UpdateSkuJob).to receive(:perform_later).with(book_title)

      post :create, params: {
        "book": {
          "title": 'You and me'
        },
        "author": {
          "first_name": 'Justus',
          "last_name": 'Brown',
          "age": 34
        }
      }
    end
  end
end
