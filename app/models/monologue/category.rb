class Monologue::Category < ActiveRecord::Base
  validates :name, uniqueness: true,presence: true
  validates :url_id, uniqueness: true,presence: true
  has_many :categorizations
  has_many :posts,through: :categorizations

  before_validation :set_url_id

  def set_url_id
    self.url_id ||= self.name.parameterize
  end

  def posts_with_category
    self.posts.published
  end

  def frequency
    posts_with_category.size
  end

end
