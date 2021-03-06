ActiveAdmin.register Payment do

  # permit_params :amount, :user_id
  
  controller do

    # def index
    #   @payments = Payment.page(params[:page]).per(10)
    # end

    def create
      @payment = Payment.new(payment_params)
  
      if @payment.save
        @user_id = @payment.user_id
        @debt_sum = Debt.where(user_id: @user_id).sum(:amount)
        @payment_sum = Payment.where(user_id: @user_id).sum(:amount)

        @total_balance = @debt_sum - @payment_sum
        User.where(id: @user_id).update(balance: @total_balance)
        flash[:info] = "Success created new data"
        redirect_to admin_payment_path(@payment)
      else
        flash[:danger] = "Something went wrong"
      end
    end

    def update
      @payment = Payment.find(params[:id])

      if @payment.update(payment_params)
        @user_id = @payment.user_id
        @debt_sum = Debt.where(user_id: @user_id).sum(:amount)
        @payment_sum = Payment.where(user_id: @user_id).sum(:amount)

        @total_balance = @debt_sum - @payment_sum
        User.where(id: @user_id).update(balance: @total_balance)

        flash[:info] = "Success updated data"
        redirect_to admin_payment_path(@payment)
      else
        flash[:danger] = "Something went wrong"
      end

    end

    def destroy
      @payment = Payment.find(params[:id])
      @payment.destroy

      @user_id = @payment.user_id
      @debt_sum = Debt.where(user_id: @user_id).sum(:amount)
      @payment_sum = Payment.where(user_id: @user_id).sum(:amount)

      @total_balance = @debt_sum - @payment_sum
      User.where(id: @user_id).update(balance: @total_balance)
      
      flash[:info] = "Success deleted data"
      redirect_to admin_payments_path
    end

    private

    def payment_params
      params.require(:payment).permit(:amount, :user_id)
    end

  end

end
