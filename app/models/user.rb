class User < ApplicationRecord
  include Rails.application.routes.url_helpers

  has_one_attached :avatar

  include Devise::JWT::RevocationStrategies::JTIMatcher
  has_one :address
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  def jwt_payload
    super
  end

  def get_image_url
    url_for(self.avatar)
  end
end
