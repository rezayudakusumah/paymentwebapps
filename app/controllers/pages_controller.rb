class PagesController < ApplicationController

  def index
    @user = User.where(code: params[:code])
    @payments = Payment.where(user_id: @user)
    @user_balance = User.where(id: @user).sum(:balance)
  end

  def new

  end

end