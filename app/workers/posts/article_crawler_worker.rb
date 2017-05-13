module Posts
  class ArticleCrawlerWorker
    include Sidekiq::Worker
    sidekiq_options :queue => :crawler
    def perform(id)
      selected_article  = Article.find(id)
      url               = selected_article.url
      document          = Nokogiri::HTML(open(url))
      title             = document.at("title").text
      description       = document.at('meta[name="description"]')['content']
      image_url         = document.at('meta[property="og:image"]')['content']
      source_host       = Addressable::URI.parse(url).host
      selected_article.update_attributes title: title, description: description, image_url: image_url, source_host: source_host
    end
  end
end
