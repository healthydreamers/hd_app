class TopicsController < ApplicationController

  def show
    @topic = Topic.find(params[:id])
    @articles = @topic.articles
  end

end