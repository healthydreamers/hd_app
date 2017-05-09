class CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def create
    @comment = @commentable.comments.new comment_params
    @comment.user = current_user
    if @comment.save
      redirect_back fallback_location: root_path, notice: "Comment posted successfully"
    else
      redirect_back fallback_location: root_path, notice: "Something went wrong"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

end
