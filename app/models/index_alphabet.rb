class IndexAlphabet < ActiveRecord::Base
  belongs_to :state
  has_many :cities, dependent: :destroy
end
