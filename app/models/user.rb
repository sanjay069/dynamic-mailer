class User < ApplicationRecord
  belongs_to :language, optional: true
def admin?
  role == "Admin"
end

def consumer?
  role == "Consumer"
end
  devise :database_authenticatable, :registerable,
         :jwt_authenticatable, jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null
end
