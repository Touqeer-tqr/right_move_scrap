State has many cities has many properties

rails generate model state name:string
has_many :index_alphabets, dependent: :destroy
has_many :cities, dependent: :destroy
has_many :properties, dependent: :destroy

rails generate model index_alphabet title:string link:string
belongs_to :state
has_many :cities, dependent: :destroy

rails generate model city name:string link:string
has_many :properties, dependent: :destroy
belongs_to :index_alphabet
belongs_to :state

rails generate model property id_from_rightmove:string, link:string, image_url:string, price:string, description:string, address:string, street:string, property_for:string, city:string, linked_on:date
belongs_to :index_alphabet
belongs_to :state
belongs_to :city


"12 ingress Road, Birmingham, b21 9hf"
"latitude"=57.118895, "longitude"=-2.155304
"latitude":57.11829598841306,"longitude":-2.157190813380934
https://maps.google.com/maps?q=57.11829598841306,-2.157190813380934&t=k
https://maps.google.com/maps?q=57.11829598841306,-2.157190813380934&t=k



Full Address
Asking Price, Last Sold Price, Last Sold Price vs Asking Price, Price Change Since Last Extract
Description, Date Listed, Last Sold Date
Property URL
Bedrooms
Days and EPC Rating if possible

The Site is Updated
Wrote scrapper for new columns
Add columns to xls file to be downloaded
chromedriver scrapper configured with heroku
