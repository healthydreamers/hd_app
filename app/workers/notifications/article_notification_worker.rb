module Notifications
  class ArticleNotificationWorker
    include Sidekiq::Worker
    include Rails.application.routes.url_helpers
    sidekiq_options :queue => :notifications
    def perform(friendly_id)
      article_url = Rails.application.routes.url_helpers.article_url(friendly_id)
    	notifier = Slack::Notifier.new "https://hooks.slack.com/services/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"
    	notifier.ping article_url
    end
  end
end