# app/models/product.rb
class Product < ApplicationRecord
  # Presence validations
  validates :name, presence: { message: "Name cannot be blank" }
  validates :description, presence: true
  validates :price, presence: true
  validates :stock, presence: true

  # Length validations
  validates :name, length: { 
    minimum: 2, 
    maximum: 50,
    too_short: "must have at least %{count} characters",
    too_long: "must have at most %{count} characters" 
  }
  validates :description, length: { maximum: 1000 }

  # Format validation
  validates :name, format: { 
    with: /\A[a-zA-Z0-9\s\-]+\z/,
    message: "can only contain letters, numbers, spaces, and hyphens" 
  }

  # Numericality validations
  validates :price, numericality: { 
    greater_than_or_equal_to: 0,
    less_than: 1000000,
    message: "must be between 0 and 1,000,000" 
  }
  
  validates :stock, numericality: { 
    only_integer: true,
    greater_than_or_equal_to: 0,
    less_than: 10000,
    message: "must be a whole number between 0 and 10,000" 
  }

  # Custom validation method
  validate :description_cannot_contain_restricted_words

  # Callback to clean data before save
  before_validation :strip_whitespace

  private

  def description_cannot_contain_restricted_words
    restricted_words = ['spam', 'scam', 'fake']
    if description.present? && restricted_words.any? { |word| description.downcase.include?(word) }
      errors.add(:description, "contains restricted words")
    end
  end

  def strip_whitespace
    self.name = name.strip if name.present?
    self.description = description.strip if description.present?
  end
end
