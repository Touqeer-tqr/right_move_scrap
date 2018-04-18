State.destroy_all
State.create([{ :id => 1, :name => "united kingdom" }, { :id => 2, :name => "london" }])

IndexAlphabet.destroy_all
index_alphabets = Home::scrape_all_indexs
IndexAlphabet.create(index_alphabets.first["united kingdom"])
IndexAlphabet.create(index_alphabets.first["london"])


Property.destroy_all
Home::scrape_properties
