class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable
  has_one :payment, dependent: :destroy
  # This line allows nested attributes for the payment model
  # so that payment details can be created or updated alongside the user
  # when creating or updating a user.
  accepts_nested_attributes_for :payment
  has_many :images, dependent: :destroy
end
