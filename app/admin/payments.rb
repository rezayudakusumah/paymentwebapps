ActiveAdmin.register Payment do

  # permit_params :amount, :user_id
  
  controller do

    def create
      @payment = Payment.new(payment_params)
  
      if @payment.save
        @user_id = @payment.user_id
        @user_balance = Payment.where(user_id: @user_id).sum(:amount)
        User.where(id: @user_id).update(balance: @user_balance)
        flash[:info] = "Success created new data"
        redirect_to admin_payment_path(@payment)
      else
        flash[:danger] = "Something went wrong"
        render "new"
      end
    end

    def destroy
      @payment = Payment.find(params[:id])
      @payment.destroy

      @user_id = @payment.user_id
      @user_balance = Payment.where(user_id: @user_id).sum(:amount)
      User.where(id: @user_id).update(balance: @user_balance)
      
      flash[:info] = "Success deleted data"
      redirect_to admin_payments_path
    end

    private

    def payment_params
      params.require(:payment).permit(:amount, :user_id)
    end

  end

end
