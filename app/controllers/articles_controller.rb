# == Schema Information
#
# Table name: articles
#
#  id          :integer          not null, primary key
#  title       :string           default(""), not null
#  description :text             default(""), not null
#  url         :string           default("")
#  source_host :string           default("")
#  slug        :string
#  topic_id    :integer
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :upvote]
  before_action :authenticate_user!, except: [:show]

  def index
    if params[:tag]
      @articles = Article.tagged_with(params[:tag])
    else
      @articles = Article.all.where(is_published: true)
    end
  end

  def show
    # SEO
    @meta_title       = meta_title @article.title
    @meta_description = @article.description
    @canonical_url    = "https://www.healthydreamers.com/articles/#{@article.slug}"
    @og_properties    = {
      title: @meta_title,
      type:  'website',
      description:  @meta_description,
      image: view_context.image_url(@article.image_url),
      url: @canonical_url
    }
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.new(article_params)
    if @article.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def url_lookup
    page = MetaInspector.new(params[:url])
    respond_to do |format|
      format.json { render :json => [
        title: page.title,
        description: page.description,
        source_host: page.host
      ] }
    end
  end

  def upvote
    @article.upvote_by current_user
    redirect_back fallback_location: root_path, notice: "Voted successfully"
  end
  
  private

  def set_article
    @article = Article.friendly.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description, :url, :source_host, :topic_id, :user_id, :tag_list)
  end

end
