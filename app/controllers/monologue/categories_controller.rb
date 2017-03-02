class Monologue::CategoriesController < Monologue::ApplicationController
  def show
    @category = retrieve_category
    if @category
      @page = nil
      @posts = @category.posts_with_category
    else
      redirect_to :root ,notice: "No post found with label \"#{params[:category]}\""
    end
  end

  private
  def retrieve_category
    Monologue::Category.where("lower(url_id) = ?", params[:url_id].mb_chars.to_s.downcase).first
  end
end
