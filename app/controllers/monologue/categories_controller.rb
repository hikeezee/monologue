class Monologue::CategoriesController < Monologue::ApplicationController
  def show
    @category = retrieve_category
    if @category
      @page = params[:page].nil? ? 1 : params[:page].to_i
      @posts = @category.posts_with_category.paginate(:page => @page, :per_page => Monologue::Config.posts_per_page).includes(:user)
      @total_pages = @posts.total_pages
    else
      redirect_to :root ,notice: "No post found with label \"#{params[:category]}\""
    end
  end

  private
  def retrieve_category
    Monologue::Category.where("lower(url_id) = ?", params[:url_id].mb_chars.to_s.downcase).first
  end
end
