class Student < ApplicationRecord
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: {minimum:2, maximum:50}
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, :uniqueness => true

  has_secure_password
  has_many :student_courses
  has_many :courses, through: :student_courses
end