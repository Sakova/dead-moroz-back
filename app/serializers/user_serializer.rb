class UserSerializer < ActiveModel::Serializer
  attributes :id, :jti, :name, :surname, :role, :email, :age, :items, :address, :avatar, :total_pages

  has_many :assessments, if: :allow_access?
  has_many :feedbacks, if: :allow_access?
  has_many :gifts, if: :allow_access?

  def address
    address = self.object.address
    return unless address.present?
    {street: address.street, house: address.house, floor: address.floor}
  end

  def avatar
    self.object.get_avatar_url if self.object.avatar.present?
  end

  def total_pages
    User.all.page(1).total_pages
  end

  def allow_access?
    if current_user.elf? || current_user.dead?
      true
    else
      false
    end
  end
end
