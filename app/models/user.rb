class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true
  validates :surname, presence: true
  validates :email, uniqueness: true
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  attribute :name, :string
  attribute :surname, :string
  attribute :email, :string
  attribute :photo, :string
  attribute :bio, :text
  attribute :posts_counter, :integer

  has_many :posts, foreign_key: 'author_id'
  has_many :comments
  has_many :likes

  def recent_posts
    posts.includes(:author).order(created_at: :desc).limit(3)
  end
end
