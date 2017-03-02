class Monologue::PostsController < Monologue::ApplicationController
  def index
    @page = params[:page].nil? ? 1 : params[:page]
    @posts = Monologue::Post.paginate(:page => @page, :per_page => Monologue::Config.posts_per_page).includes(:user).published
  end

  def show
    if monologue_current_user
      @post = Monologue::Post.default.where("url = :url", {url: params[:post_url]}).first
    else
      @post = Monologue::Post.published.where("url = :url", {url: params[:post_url]}).first
    end
    if @post.nil?
      not_found
    end
  end

  def feed
    @posts = Monologue::Post.published.limit(25)
    if params[:categories].present?
      categories = Monologue::Category.where(name: params[:categories].split(",")).pluck(:id)
      @posts = @posts.joins(:categorizations).where("monologue_categorizations.category_id in (?)", categories)
    end
    if params[:tags].present?
      tags = Monologue::Tag.where(name: params[:tags].split(",")).pluck(:id)
      @posts = @posts.joins(:taggings).where("monologue_taggings.tag_id in (?)", tags)
    end
    render 'feed', layout: false
  end
end
