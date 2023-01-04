class User < ApplicationRecord
  include Rails.application.routes.url_helpers

  has_one_attached :avatar

  paginates_per USERS_PER_PAGE

  include Devise::JWT::RevocationStrategies::JTIMatcher
  has_one :address
  has_many :gifts
  has_many :assessments
  has_many :feedbacks
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  def jwt_payload
    super
  end

  enum role: %i[user elf dead]

  def get_avatar_url
    options = {width: 500, crop: :fill}
    Cloudinary::Utils.cloudinary_url(self.avatar.key, options)
  end
end
