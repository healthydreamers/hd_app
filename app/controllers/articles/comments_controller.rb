class Articles::CommentsController < CommentsController
  before_action :set_commentable
  after_action  :increment_comments

  private

  def increment_comments
  	cached_comments_count = @commentable.comments.size
  	@commentable.update_attributes cached_comments_count: cached_comments_count
  end

  def set_commentable
    @commentable = Article.friendly.find(params[:article_id])
  end
end
