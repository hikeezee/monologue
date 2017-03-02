module Monologue
  module CategoriesHelper

    #Number of sizes defined in the css
    NUMBER_OF_LABEL_SIZES = 5

    def category_url(category)
      "#{Monologue::Engine.routes.url_helpers.root_path}category/#{URI.encode(category.url_id.mb_chars.to_s.downcase)}"
    end

    def label_for_category(category, min, max)
      "label-size-#{size_for_category(category, min, max)}"
    end

    def size_for_category(category, min, max)
      #logarithmic scaling based on the number of occurrences of each category
      if min<max && category.frequency>0
        1 + ((NUMBER_OF_LABEL_SIZES-1)*(log_distance_to_min(category.frequency, min))/log_distance_to_min(max, min)).round
      else
        1
      end
    end

    private

    def log_distance_to_min(value, min)
      Math.log(value)-Math.log(min)
    end
  end
end