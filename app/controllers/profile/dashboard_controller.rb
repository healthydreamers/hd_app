class Profile::DashboardController < Profile::ProfileController
	
	def index
    @user = current_user
    @articles = @user.articles.includes(:articles)
    @articles_count = @articles.count
    @published_articles = @user.articles.published
    @unpublished_articles = @user.articles.unpublished
  end

end
