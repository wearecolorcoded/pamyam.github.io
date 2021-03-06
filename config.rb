###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (https://middlemanapp.com/advanced/dynamic_pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
#  :which_fake_page => "Rendering a fake page with a local variable" }

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

activate :directory_indexes

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

activate :blog do |blog|
  blog.permalink = "{title}.html"
end

# Methods defined in the helpers block are available in templates
helpers do
  def upcoming_events
    blog.articles.find_all do |article|
      !article.metadata[:page]['recap'].present? && !article.metadata[:page]['done'].present?
    end
  end

  def latest_event
    upcoming_events.first
  end

  def past_events
    articles = blog.articles.find_all do |article|
      article.metadata[:page]['recap'].present? || article.metadata[:page]['done'].present?
    end
    articles.reverse
  end

  def partnership(article)
    partnerships = article.metadata[:page]['partner'].split(',')
    partner_pages = article.metadata[:page]['partner_page'].split(',')
    pairs = {}
    partnerships.each_with_index do |partnership, idx|
      partner = partnerships[idx + 1].present? ? "#{partnership}," : "#{partnership}"
      pairs[partner] = partner_pages[idx]
    end
    pairs
  end

end

set :relative_links, true

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

set :fonts_dir,  'fonts'

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end

activate :deploy do |deploy|
  deploy.method = :git
  deploy.branch = 'master'
  deploy.build_before = true
end
