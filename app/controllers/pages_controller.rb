class PagesController < ApplicationController
    before_action :authorize, only: :search

    def search
        @suggestions = Suggestion.where(user_id: current_user.id).order(:hits).pluck(:term)
        # Suggestion.create_valid_suggestion(params[:title], current_user.id) if params[:title].present?
        @articles = Article.articles_lookup(params[:title])
    end

    def get_suggestions
        render json: Suggestion.where(user_id: current_user.id).order(:hits).pluck(:term)
    end

    def build_suggestion
        res = Suggestion.create_valid_suggestion(params[:text], current_user.id)
        render json: res
    rescue => e
        render json: { message: 'Invalid search Term' }, status: 403
    end
end
