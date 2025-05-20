class Template < ApplicationRecord
  belongs_to :language

  def self.ransackable_attributes(auth_object = nil)
    ["body", "created_at", "id", "language", "title", "updated_at", "user_id"]
  end
  
  def self.ransackable_associations(auth_object = nil)
    ["language"]
  end

  def self.ransackable_attributes(auth_object = nil)
    super + ['language_id']  
  end
end
