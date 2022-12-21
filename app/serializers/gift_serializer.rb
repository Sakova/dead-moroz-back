class GiftSerializer < ActiveModel::Serializer
  attributes :id, :description, :is_selected, :created_by, :photo

  def photo
    self.object.get_photo_url if self.object.photo.present?
  end
end
