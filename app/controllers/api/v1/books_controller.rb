module Api
  module V1
    class BooksController < Api::V1::BaseController
      def initialize
        @model = Book
        super
      end

      private

      def model_params
        params.require(:book).permit(:title, :author)
      end
    end
  end
end
