ActiveAdmin.register Debt do

  controller do

    def create
      @debt = Debt.new(debt_params)

      if @debt.save
        @user_id = @debt.user_id
        @debt_sum = Debt.where(user_id: @user_id).sum(:amount)
        @payment_sum = Payment.where(user_id: @user_id).sum(:amount)
        @total_balance = @debt_sum - @payment_sum
        User.where(id: @user_id).update(balance: @total_balance)
        flash[:info] = "Success created new data"
        redirect_to admin_debt_path(@debt)
      else
        flash[:danger] = "Something went wrong"
      end
    end

    def update
      @debt = Debt.find(params[:id])

      if @debt.update(debt_params)
        @user_id = @debt.user_id
        @debt_sum = Debt.where(user_id: @user_id).sum(:amount)
        @payment_sum = Payment.where(user_id: @user_id).sum(:amount)

        @total_balance = @debt_sum - @payment_sum
        User.where(id: @user_id).update(balance: @total_balance)

        flash[:info] = "Success updated data"
        redirect_to admin_payment_path(@debt)
      else
        flash[:danger] = "Something went wrong"
      end

    end

    def destroy
      @debt = Debt.find(params[:id])
      @debt.destroy

      @user_id = @debt.user_id
      @debt_sum = Debt.where(user_id: @user_id).sum(:amount)
      @payment_sum = Payment.where(user_id: @user_id).sum(:amount)

      @total_balance = @debt_sum - @payment_sum
      User.where(id: @user_id).update(balance: @total_balance)
      
      flash[:info] = "Success deleted data"
      redirect_to admin_debts_path
    end

    private

    def debt_params
      params.require(:debt).permit(:amount, :user_id)
    end

  end
  
end
