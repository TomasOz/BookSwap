class BooksController < ApplicationController
  before_action :check_owner, only: [:create, :edit, :update]

  def index
    @books = Book.for_user(current_user.id)
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id

    if @book.save
      redirect_to @book, notice: 'Book was successfully created.'
    else
      render :new
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to @book, notice: 'Book was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path, notice: 'Book was successfully deleted.'
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :description)
  end

  def check_owner
    redirect_to books_path, notice: 'This is not your book' if !Book.for_user(current_user.id).where(id: params[:id]).first
  end
end