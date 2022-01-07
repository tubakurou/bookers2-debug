class BookCommentsController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    comment = current_user.book_comment.new(book_comment_params)
    comment.book_id = book.id
   if  comment.save
   render :book_comments
 else
   render 'books/show'

  end

  def destroy
    BookComment.find_by(id: params[:id]).destroy
    render :book_comments
  end




 private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
