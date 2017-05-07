class DashboardController < ApplicationController

  def index
    @topics = Topic.includes(:articles)
  end

end