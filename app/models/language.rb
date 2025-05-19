class Language < ApplicationRecord
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "language_name", "status", "updated_at"]
  end	
end
