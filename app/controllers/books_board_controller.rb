class BooksBoardController < ApplicationController
  def index
    @books = Book.all
  end
end
