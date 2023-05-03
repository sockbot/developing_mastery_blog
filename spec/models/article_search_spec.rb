require 'rails_helper'

RSpec.describe ArticleSearch, type: :model do

  describe "model validity" do
    it "has add and reduce methods that can be called" do
      article_search = ArticleSearch.new

      article_search.add_condition("title", "hello")
      query = article_search.build_query()
      expect(query).to eq(Article.where("title ILIKE ?", "%hello%"))
    end
  end
end
