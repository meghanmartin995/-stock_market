class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @api = StockQuote::Stock.new(api_key: 'pk_825aa235840141d69333256db3cff8dc')
    if params[:search].present?
      begin
        @stock = StockQuote::Stock.quote(params[:search])
      rescue
        @error = "That symbol doesn't exist. Search again."
      end
    end
  end
end
