class GiftSerializer < ActiveModel::Serializer
  attributes :id, :description, :is_selected, :created_by, :photo, :total_pages

  def photo
    self.object.get_photo_url if self.object.photo.present?
  end

  def total_pages
    current_user.gifts.page(1).total_pages
  end
end
