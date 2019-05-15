class Order < ApplicationRecord
  enum state: {Processing: 0, Failed: 1, Completed: 2, Cancelled: 3}
  belongs_to :user
  has_many :order_products
end
