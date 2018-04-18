class City < ActiveRecord::Base
  has_many :properties, dependent: :destroy
  belongs_to :index_alphabet
  belongs_to :state
end
