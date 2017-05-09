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

class Article < ApplicationRecord
  belongs_to :topic
  belongs_to :user
  has_many :comments, as: :commentable
  validates :title, :description, presence: true
  
  extend FriendlyId
	friendly_id :title, use: :slugged

	private

	def should_generate_new_friendly_id?
  	slug.nil? || title_changed?
	end

end
