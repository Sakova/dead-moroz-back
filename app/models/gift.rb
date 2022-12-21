class Gift < ApplicationRecord
  belongs_to :user
  has_one_attached :photo

  enum created_by: %i[child elf]

  def get_photo_url
    options = {height: 312, crop: :fill, quality: 60}
    Cloudinary::Utils.cloudinary_url(self.photo.key, options)
  end

end