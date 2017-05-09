class Articles::CommentsController < CommentsController
  before_action :set_commentable

  private

  def set_commentable
    @commentable = Article.friendly.find(params[:article_id])
  end
end
