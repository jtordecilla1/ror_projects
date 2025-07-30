class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  has_many :friendships
  has_many :friends, through: :friendships
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def stock_already_tracked?(ticker_symbol)
     stock = Stock.check_db(ticker_symbol)
     return false unless stock
     stocks.where(id: stock.id).exists?
  end

  def under_stock_limit?
    stocks.count < 10
  end

  def can_track_stock?(ticker_symbol)
    !stock_already_tracked?(ticker_symbol) && under_stock_limit?
  end

  def full_name
    "#{first_name} #{last_name}".strip
  end

  def friends_with?(user)
    friendships.exists?(friend: user)
  end

  def self.search_friend(name)
    return nil if name.blank?
    name = name.strip.downcase
    where("lower(first_name) LIKE :name OR lower(last_name) LIKE :name OR lower(email) LIKE :name", 
          name: "%#{name}%").first
  end
  
  def search_my_friends(name)
    return [] if name.blank?
    name = name.strip.downcase
    friends.where("lower(first_name) LIKE :name OR lower(last_name) LIKE :name", name: "%#{name}%")
  end
end
