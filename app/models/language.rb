class Language < ApplicationRecord
    has_many :templates

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "language_name", "status", "updated_at"]
  end	
  def self.ransackable_associations(auth_object = nil)
    ["templates"]
  end
  
end
