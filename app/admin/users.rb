ActiveAdmin.register User do

  permit_params :name, :identity_card, :address, :contact, :balance
  
end
