class UserSerializer < ActiveModel::Serializer
  attributes :items, :email, :avatar, :jti, :name, :surname, :age, :address

  def address
    user_address = self.object.address
    return if user_address.blank?
    { street: user_address.street, house: user_address.house, floor: user_address.floor}
  end
end
