# app/models/product.rb
class Product < ApplicationRecord
  # Active Storage attachments
  has_one_attached :main_image
  has_many_attached :additional_images
  has_one_attached :manual

  # Validations for attachments
  validates :main_image, attached: true, 
                        size: { less_than: 5.megabytes, message: 'must be less than 5MB' },
                        content_type: { in: ['image/png', 'image/jpeg', 'image/jpg'], 
                                      message: 'must be a PNG, JPEG, or JPG' }

  validates :additional_images, content_type: { in: ['image/png', 'image/jpeg', 'image/jpg'],
                                              message: 'must be PNG, JPEG, or JPG' },
                              size: { less_than: 5.megabytes, 
                                    message: 'must be less than 5MB' },
                              limit: { max: 5, message: 'cannot have more than 5 images' },
                              if: :additional_images_attached?

  validates :manual, content_type: { in: 'application/pdf', 
                                   message: 'must be a PDF' },
                    size: { less_than: 10.megabytes, 
                           message: 'must be less than 10MB' },
                    if: :manual_attached?

  private

  def additional_images_attached?
    additional_images.attached?
  end

  def manual_attached?
    manual.attached?
  end
end
