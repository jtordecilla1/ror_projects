class StocksController < ApplicationController
  def search
    
    @stock = Stock.new_lookup(params[:stock])
    if @stock
      if current_user.stocks.contains?(@stock)
        flash.now[:alert] = "#{@stock.ticker} is already in your portfolio."
      else
      respond_to do |format|
        format.html { render 'users/my_portfolio' }
        format.js { render partial: 'users/result', locals: { stock: @stock } }
      end
    end
    else
      flash.now[:alert] = "Stock not found. Please check the ticker symbol."
      respond_to do |format|
        format.html { render 'users/my_portfolio' }
        format.js { render partial: 'users/result', locals: { stock: @stock } }
      end
    end 
  end
end