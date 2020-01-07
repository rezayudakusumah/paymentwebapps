ActiveAdmin.register Payment do

  permit_params :amount, :user_id
  
end
