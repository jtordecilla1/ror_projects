class UserStocksController < ApplicationController
  def create
    stock = Stock.check_db(params[:ticker])
    if stock.blank?
      stock = Stock.new_lookup(params[:ticker])
      stock.save
    end
    @user_stock = UserStock.create(user: current_user, stock: stock)
    flash[:notice] = "#{stock.ticker} was successfully added to your portfolio."
    redirect_to my_portfolio_path
  end

  def destroy
    stock = Stock.check_db(params[:ticker])
    if stock.present?
      user_stock = UserStock.where(user: current_user, stock: stock).first
      user_stock.destroy if user_stock
      flash[:notice] = "#{stock.ticker} was successfully removed from your portfolio."
    else
      flash[:alert] = "Stock not found in your portfolio."
    end
    redirect_to my_portfolio_path
  end
end
