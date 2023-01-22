class Article < ApplicationRecord
    validates :title, presence: true, uniqueness: true

    def self.articles_lookup(term = nil)
        return Article.where('0=1') unless term.present?
        Article.where('title iLike ?', "%#{term}%").or(
            Article.where('description iLike ?', "%#{term}%")
        )
    end
end
