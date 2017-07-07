SitemapGenerator::Sitemap.default_host = "https://healthydreamers.com"

SitemapGenerator::Sitemap.create do
  #add root_path, :changefreq => 'daily'
  Article.where(articles: { is_published: true }).find_each do |article|
		add article_path(article.slug), lastmod: article.updated_at
  end
end
