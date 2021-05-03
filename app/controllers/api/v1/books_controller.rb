module Api
  module V1
    class BooksController < Api::V1::BaseController
      def initialize
        @model = Book
        super
      end

      def index
        books = Book.all
        render json: BooksRepresenter.new(books).as_json
      end

      private

      def model_params
        params.require(:book).permit(:title, :author)
      end
    end
  end
end
