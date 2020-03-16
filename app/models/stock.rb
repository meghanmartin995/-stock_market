class Stock < ApplicationRecord
  belongs_to :user
  #validates :ticker, uniqueness: true
end
