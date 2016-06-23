class CommentsController < ApplicationController
  before_action :require_login
  def create
    comment = Comment.new(comments_params)
    if comment.save
      flash[:notice] = "Your comment has been added successfully!"
    else
      flash[:errors] = comment.errors.full_messages
    end
      redirect_to "/events/#{comment.event_id}"
  end

  private
  def comments_params
      params.require(:comment).permit(:comment, :user_id, :event_id)
  end
end
