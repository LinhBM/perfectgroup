class Product < ApplicationRecord
  belongs_to :category
  belongs_to :user

  has_one :order_item
  has_many :cmt_user, through: :comment_products,
    class_name: User.name
  has_many :comment_products, dependent: :destroy

  ratyrate_rateable "quality"

  has_attached_file :product_image, styles: {thumb: "270x180#"},
    default_url: "https://demo.productdent.com//img/no_product.png"
  validates_attachment_content_type :product_image,
    content_type: /\Aimage\/.*\z/

  searchkick text_start: [:title]
end
