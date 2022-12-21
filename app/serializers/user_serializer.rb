class UserSerializer < ActiveModel::Serializer
  attributes :id, :jti, :name, :surname, :role, :email, :age, :items, :address, :avatar

  def address
    address = self.object.address
    return unless address.present?
    {street: address.street, house: address.house, floor: address.floor}
  end

  def avatar
    self.object.get_avatar_url if self.object.avatar.present?
  end
end
