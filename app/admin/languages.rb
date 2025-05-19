# ActiveAdmin.register Language do

#   # See permitted parameters documentation:
#   # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#   #
#   # Uncomment all parameters which should be permitted for assignment
#   #
#   # permit_params :language_name, :status
#   #
#   # or
#   #
#   # permit_params do
#   #   permitted = [:language_name, :status]
#   #   permitted << :other if params[:action] == 'create' && current_user.admin?
#   #   permitted
#   # end
  
# end
ActiveAdmin.register Language do
  permit_params :language_name, :status

  form do |f|
    f.inputs do
      f.input :language_name
      f.input :status, as: :select, collection: ["enable", "disable"]
    end
    f.actions
  end
end
