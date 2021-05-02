require 'rails_helper'

describe 'Books API', type: :request do
  describe 'GET books' do
    before do
      FactoryBot.create(:book, title: '1984', author: 'George Orwell')
      FactoryBot.create(:book, title: 'Wizard of Oz', author: 'Not me')
    end

    it 'should return all books' do
      get '/api/v1/books'
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end
  describe 'CREATE BOOK' do
    it 'should create a book' do
      expect do
        post '/api/v1/books', params: {
          book: {
            title: 'This is my test book',
            author: 'Thomas'
          }
        }
      end.to change { Book.count }.from(0).to(1)
      expect(response).to have_http_status(:created)
    end
    it 'should refuse a book without author' do
      post '/api/v1/books', params: {
        book: {
          title: 'This is my test book'
        }
      }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'DELETE Book' do
    let!(:book) { FactoryBot.create(:book, title: '1984', author: 'George Orwell') }
    # ! will create the book right when test starts, no lazy loading

    it 'deletes a book' do
      expect do
        delete "/api/v1/books/#{book.id}"
      end.to change { Book.count }.from(1).to(0)
      expect(response).to have_http_status(:no_content)
    end
  end
end
