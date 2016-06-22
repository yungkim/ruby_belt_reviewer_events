class CommentsController < ApplicationController
  def create
    puts "sdfafdsdsfadsaffdsafdsa"
    puts comments_params
    puts "fdsdsffds"
    comment = Comment.new(comments_params)
    if comment.save
      # redirect_to '/events'
      flash[:notice] = "Your comment has been added successfully!"
    else
      # redirect_to '/events'
      flash[:errors] = comment.errors.full_messages
    end
      redirect_to "/events/#{comment.event_id}"
  end

  private
  def comments_params
      params.require(:comment).permit(:comment, :user_id, :event_id)
  end
end
