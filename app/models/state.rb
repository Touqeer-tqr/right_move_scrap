class State < ActiveRecord::Base
  has_many :index_alphabets, dependent: :destroy
  has_many :cities, dependent: :destroy
  has_many :properties, dependent: :destroy
end
