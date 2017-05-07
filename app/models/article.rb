class Article < ApplicationRecord
  belongs_to :topic
  belongs_to :user

  extend FriendlyId
	friendly_id :title, use: :slugged

	private

	def should_generate_new_friendly_id?
  	slug.nil? || title_changed?
	end

end
