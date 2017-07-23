# == Schema Information
#
# Table name: topics
#
#  id         :integer          not null, primary key
#  name       :string           default(""), not null
#  slogan     :string           default(""), not null
#  slug       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TopicsController < ApplicationController

  def index
    @topics     = Topic.published_articles
    @healthy    = Topic.healthy_articles
    @wealthy    = Topic.wealthy_articles
    @wise       = Topic.wise_articles

    # SEO
    @meta_title = meta_title ''
    @meta_description = 'Healthy Dreamers is a curation of articles & videos to help you follow a Healthy, Wealthy & Wise life.'
    @canonical_url    = "https://www.healthydreamers.com/"
    @og_properties    = {
      title: "Healthy Dreamers",
      type:  "website",
      description:  @meta_description,
      image: view_context.image_url("https://res.cloudinary.com/healthydreamers/image/upload/v1500672903/social/share.jpg"),
      url: @canonical_url
    }

  end

  def show
    @topic    = Topic.friendly.find(params[:id])
    @articles = @topic.articles.where(is_published: true)
    
    # SEO
    @meta_title       = meta_title @topic.name
    @meta_description = @topic.slogan
    @canonical_url    = "https://www.healthydreamers.com/topics/#{@topic.slug}"
    @og_properties    = {
      title: @meta_title,
      type:  'website',
      description:  @meta_description,
      image: view_context.image_url("https://res.cloudinary.com/healthydreamers/image/upload/v1500672903/social/share.jpg"),
      url: @canonical_url
    }
  end

end