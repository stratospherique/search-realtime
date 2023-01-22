class Suggestion < ApplicationRecord
    validates :term, presence: true, uniqueness: true

    belongs_to :user

    class << self
        def create_valid_suggestion(term = nil, user_id = nil)
            sanitized_term = sanitize_suggestion!(term)
            raise 'Invalid suggestion text!' unless valid_structure?(sanitized_term) # || valid_meaning?(sanitized_term)
            suggestion = Suggestion.find_or_initialize_by({
                term: term,
                user_id: user_id
            })
            if suggestion.persisted?
                suggestion.hits += 1
            else
                suggestion.hits = 1
            end
            suggestion.save!
            return Suggestion.where(user_id: user_id).order(:hits).pluck(:term)
        end
    
        private
        def valid_structure?(text)
            regex = /\b[^.!?]+[.!?]+/
            regex.match text
        end
    
        def valid_meaning?(text)
            true # I believe it requires a validation from an external API
        end
    
        def sanitize_suggestion!(text)
            raise 'Unrecognized Term!' unless text.present?
            text
        end
    end
end
