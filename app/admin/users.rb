ActiveAdmin.register User do

  permit_params :name, :identity_card, :address, :contact, :balance

  form do |f|
    inputs "Details" do
      input :name
      input :identity_card
      input :address
      input :contact
    end
    actions
  end

  # controller do

  #   def update
    
  #   end
  # end
end
