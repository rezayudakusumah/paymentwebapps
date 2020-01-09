ActiveAdmin.register User do

  permit_params :name, :identity_card, :address, :contact, :balance

  form do |f|
    inputs "Details" do
      input :name
      input :identity_card
      input :address
      input :contact
      input :balance
    end
    actions
  end

  controller do
    require 'securerandom'

    before_action :find_user, only: :show
    after_action :random_code, only: :create

    def random_code
      @random_digit = SecureRandom.hex(15)
      User.where(id: @user.id).update(code: @random_digit)
    end

    def create
      @user = User.new(user_params)

      if @user.save
        flash[:info] = "Success created new data"
        redirect_to admin_user_path(@user)
      else
        flash[:danger] = "Something went wrong"
      end
    end

    private

    def find_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :identity_card, :address, :contact, :balance, :code, :updated_at, :created_at)
    end

  end
end
