require 'net/http'

module Api
  module V1
    class BooksController < Api::V1::BaseController
      MAX_PAGINATION_LIMIT = 100

      def initialize
        @model = Book
        super
      end

      def index
        books = Book.limit(limit).offset(params[:offset])
        render json: BooksRepresenter.new(books).as_json
      end

      def create
        author = Author.create!(author_params)
        book = Book.new(book_params.merge(author_id: author.id))

        UpdateSkuJob.perform_later(book_params[:title])

        if book.save
          render json: BookRepresenter.new(book).as_json, status: :created
        else
          render json: book.errors, status: :unprocessable_entity
        end
      end

      private

      def book_params
        params.require(:book).permit(:title)
      end

      def author_params
        params.require(:author).permit(:first_name, :last_name, :age)
      end

      def limit
        [
          params.fetch(:limit, MAX_PAGINATION_LIMIT).to_i, MAX_PAGINATION_LIMIT
        ].min
      end
    end
  end
end
