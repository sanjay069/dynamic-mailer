class Template < ApplicationRecord
   # belongs_to :user, optional: true
  def self.ransackable_attributes(auth_object = nil)
    ["body", "created_at", "id", "subject", "title", "updated_at", "user_id"]
  end
  def self.ransackable_associations(auth_object = nil)
    ["user"]
  end  
end
