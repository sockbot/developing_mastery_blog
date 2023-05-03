class ArticleSearch
  @wheres
  
  def initialize()
    @wheres = []
  end

  def add_condition(field, query)
    @wheres.append(Article.where("#{field} ILIKE ?", "%#{query}%"))
  end

  def build_query()
    @wheres.reduce(:or)
  end
end