class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
    :recoverable, :rememberable, :trackable, :validatable

  has_many :feedbacks, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :likeships, dependent: :destroy
  has_many :likeship_comment_products, through: :likeships,
    class_name: CommentProduct.name
  has_many :products, dependent: :destroy
  has_many :comment_products, dependent: :destroy
  has_many :cmt_products, through: :comment_products,
    class_name: Product.name
  has_many :relationships
  has_many :comment_products
  has_many :active_relationships, class_name: Relationship.name,
    foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name,
    foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  has_attached_file :image, styles: {small: "80x80#", med: "100x100#",
    large: "200x200#", verysmall: "30x30#"},
    default_url: "missing.png"

  validates_attachment :image,
    content_type: {content_type: /\Aimage/},
    size: {in: 0..10.megabytes}

  scope :only_sale_man, (->_user{where role: 1})
  scope :unless_admin, (->_user{where("role not in (0)")})

  searchkick text_start: :username

  ratyrate_rateable "quality"

  ratyrate_rater

  enum role: [:admin, :sale_man, :buy_man, :locked]
  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role ||= :sale_man
  end

  def follow other_user
    following << other_user
  end

  def unfollow other_user
    following.delete other_user
  end

  def following? other_user
    following.include? other_user
  end

  def current_user? user
    self == user
  end

  def like comment_id
    likeships.create comment_product_id: comment_id
  end

  def unlike liking
    liking.destroy
  end

  def liking? comment_id
    likeships.find_by comment_product_id: comment_id
  end
end
