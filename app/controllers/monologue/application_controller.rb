class Monologue::ApplicationController < ApplicationController
  include Monologue::ControllerHelpers::User

  layout Monologue::Config.layout if Monologue::Config.layout # TODO: find a way to test that. It was asked in issue #54 (https://github.com/jipiboily/monologue/issues/54)

  before_filter :recent_posts, :all_categories, :all_tags, :archive_posts

  def recent_posts
    @recent_posts = Monologue::Post.published.limit(3)
  end

  def all_categories
    @categories = Monologue::Tag.order("name").select{|t| t.frequency>0}
    #could use minmax here but it's only supported with ruby > 1.9'
    @categories_frequency_min = @categories.map{|t| t.frequency}.min
    @categories_frequency_max = @categories.map{|t| t.frequency}.max
  end

  def all_tags
    @tags = Monologue::Tag.order("name").select{|t| t.frequency>0}
    #could use minmax here but it's only supported with ruby > 1.9'
    @tags_frequency_min = @tags.map{|t| t.frequency}.min
    @tags_frequency_max = @tags.map{|t| t.frequency}.max
  end

  def not_found
    # fallback to the default 404.html page from main_app.
    file = Rails.root.join('public', '404.html')
    if file.exist?
      render file: file.cleanpath.to_s.gsub(%r{#{file.extname}$}, ''),
         layout: false, status: 404, formats: [:html]
    else
      render action: "404", status: 404, formats: [:html]
    end
  end

  def archive_posts
    @archive_posts = {}
    @first_post_year = DateTime.now.year

    # limit to 100 for safety reasons
    posts = Monologue::Post.published.limit(100)
    if posts.length > 0
      @archive_posts = posts.group_by {
        |post| post.published_at.beginning_of_month.strftime("%Y %-m")
      }
      @first_post_year = posts.last.published_at.year
    end
  end

end
