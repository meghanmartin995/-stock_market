class StocksController < ApplicationController
  before_action :set_stock, only: []
  before_action :correct_user, only: []

  def index
    @api = StockQuote::Stock.new(api_key: 'pk_825aa235840141d69333256db3cff8dc')
    if params[:query].present?
      begin
        @stock = StockQuote::Stock.quote(params[:query])
      rescue
        @error = "That symbol doesn't exist. Search again."
      end
    end
  end

  def show
    @user_stock = Stock.find(params[:id])
    @stock = StockQuote::Stock.quote(@user_stock.ticker)
  end

  def new
    raise
    @stock = Stock.new
  end

  def create
    ticker = params[:param1]
    @user = current_user
    @stock = @user.stocks.new(ticker: ticker)
   # @stock = Stock.new(ticker: StockQuote::Stock.quote(params[:query]), user_id: current_user)
      if @stock.save!
        redirect_to dashboard_path
      else
        render :index
      end
  end

private

  def correct_user
    @ticker = current_user.stocks.find_by(id: params[:id])
    if @ticker.nil?
      redirect_to stocks_path
    end
    end

  def set_stock
    @stock = Stock.find(params[:id])
  end

  def stock_params
    #params.require(:stock).permit(:ticker, :user_id)
    #params.permit(tickerparam1, :user_id)
  end
end
