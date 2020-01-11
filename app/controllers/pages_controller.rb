class PagesController < ApplicationController

  def index
    @user = User.where(code: params[:code])
    @payments = Payment.where(user_id: @user)
    @debts = Debt.where(user_id: @user)
    @user_balance = User.where(id: @user).sum(:balance)
    @user_name = User.where(id: @user).pluck(:name).first
  end

  def new

  end

end