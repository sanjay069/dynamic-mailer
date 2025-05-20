# ActiveAdmin.register Template do

#   # See permitted parameters documentation:
#   # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#   #
#   # Uncomment all parameters which should be permitted for assignment
#   #
#   # permit_params :subject, :title, :body, :user_id
#   #
#   # or
#   #
#   # permit_params do
#   #   permitted = [:subject, :title, :body, :user_id]
#   #   permitted << :other if params[:action] == 'create' && current_user.admin?
#   #   permitted
#   # end
  
# end
# ActiveAdmin.register Template do
#   permit_params :language, :title, :body
# end
# ActiveAdmin.register Template do
#   # Add filters
#   filter :title
#   filter :body
#   filter :language, as: :select, collection: -> { Language.all.pluck(:language_name, :id) }

#   index do
#     selectable_column
#     id_column
#     column :title
#     column :body
#     column("Language") { |template| template.language&.language_name }
#     actions
#   end
# end
ActiveAdmin.register Template do
  permit_params :title, :body, :language_id, :subject

  filter :title
  filter :body
  filter :language, as: :select, collection: -> { Language.pluck(:language_name, :id) }

  index do
    selectable_column
    id_column
    column :title
    column :body
    column "Language" do |template|
      template.language&.language_name
    end
    actions
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :body
      f.input :language, as: :select, collection: Language.where(status: "enable").pluck(:language_name, :id)
    end
    f.actions
  end

end
