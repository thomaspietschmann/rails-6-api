require 'rails_helper'

describe 'Books API', type: :request do
  let(:first_author) { FactoryBot.create(:author, first_name: 'George', last_name: 'Mayer', age: 46) }
  let(:second_author) { FactoryBot.create(:author, first_name: 'Melanie', last_name: 'Broons', age: 22) }

  describe 'GET books' do
    before do
      FactoryBot.create(:book, title: '1984', author: first_author)
      FactoryBot.create(:book, title: 'Hello from Hell', author: second_author)
    end

    it 'should return all books' do
      get '/api/v1/books'
      expect(response).to have_http_status(:success)
      expect(response_body.size).to eq(2)
      expect(response_body).to eq([
                                    {
                                      'id' => 1,
                                      'title' => '1984',
                                      'author_name' => 'George Mayer',
                                      'author_age' => 46
                                    },
                                    {
                                      'id' => 2,
                                      'title' => 'Hello from Hell',
                                      'author_name' => 'Melanie Broons',
                                      'author_age' => 22
                                    }
                                  ])
    end
    it 'returns a subset of books based on limit' do
      get '/api/v1/books', params: { limit: 1 }
      expect(response).to have_http_status(:success)
      expect(response_body.size).to eq(1)
      expect(response_body).to eq([
                                    {
                                      'id' => 1,
                                      'title' => '1984',
                                      'author_name' => 'George Mayer',
                                      'author_age' => 46
                                    }
                                  ])
    end
    it 'returns a subset of books based on limit and offset' do
      get '/api/v1/books', params: { limit: 1, offset: 1 }
      expect(response).to have_http_status(:success)
      expect(response_body.size).to eq(1)
      expect(response_body).to eq([
                                    {
                                      'id' => 2,
                                      'title' => 'Hello from Hell',
                                      'author_name' => 'Melanie Broons',
                                      'author_age' => 22
                                    }
                                  ])
    end
  end
  describe 'CREATE BOOK' do
    it 'should create a book' do
      expect do
        post '/api/v1/books', params: {
          book: {
            title: 'This is my test book'
          },
          author: {
            first_name: 'Thomas',
            last_name: 'Weir',
            age: 48
          }
        }
      end.to change { Book.count }.from(0).to(1)
      expect(response).to have_http_status(:created)
      expect(Author.count).to eq(1)
      expect(response_body).to eq({
                                    'id' => 1,
                                    'title' => 'This is my test book',
                                    'author_name' => 'Thomas Weir',
                                    'author_age' => 48
                                  })
    end
  end

  describe 'DELETE Book' do
    let!(:book) { FactoryBot.create(:book, title: '1984', author: first_author) }
    # ! will create the book right when test starts, no lazy loading

    it 'deletes a book' do
      expect do
        delete "/api/v1/books/#{book.id}"
      end.to change { Book.count }.from(1).to(0)
      expect(response).to have_http_status(:no_content)
    end
  end
end
