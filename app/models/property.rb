class Property < ActiveRecord::Base
  belongs_to :index_alphabet
  belongs_to :state
  belongs_to :city
end
