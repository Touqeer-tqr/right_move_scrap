class Home < ActiveRecord::Base
  require 'httparty'
  require 'nokogiri'

  BASE_URL = "http://www.rightmove.co.uk"

  paginates_per 50

  def self.scrape_all_indexs
    uk_london_index_aplhabets = []
    page = HTTParty.get(BASE_URL)
    nokogiri_page = Nokogiri::HTML(page)
    index_aplhabets = nokogiri_page.css('div#majorPlacesContainer > ul.footer-links.footer-links-cols.bdr-b > li.footer-links-group')
    i = 1
    index_aplhabets.each do |li_element|
      array_of_li = []
      li_element.css('ul > li').each do |sub_li_element|
        link = sub_li_element.css('a')
        array_of_li << { title: link.text.downcase, link: BASE_URL+link.attribute('href').value, state_id: i} if link.text.downcase.include?('-') || link.text.downcase.size<2
      end
      uk_london_index_aplhabets.push(li_element.css('h4').text.downcase.gsub(":", "") => array_of_li)
      i += 1
    end
    uk_london_index_aplhabets
  end

  # get_all_indexs


  def self.get_cities
    
    uk_london_index_aplhabets = {"united kingdom"=>[{:index_aplhabet=>"a-be", :url=>"http://www.rightmove.co.uk/uk-property-search-a-be.html"}, {:index_aplhabet=>"bl-bu", :url=>"http://www.rightmove.co.uk/uk-property-search-bl-bu.html"}, {:index_aplhabet=>"ca-ce", :url=>"http://www.rightmove.co.uk/uk-property-search-ca-ce.html"}, {:index_aplhabet=>"ch-con", :url=>"http://www.rightmove.co.uk/uk-property-search-ch-con.html"}, {:index_aplhabet=>"cor-cu", :url=>"http://www.rightmove.co.uk/uk-property-search-cor-cu.html"}, {:index_aplhabet=>"d", :url=>"http://www.rightmove.co.uk/uk-property-search-d.html"}, {:index_aplhabet=>"ed-f", :url=>"http://www.rightmove.co.uk/uk-property-search-ed-f.html"}, {:index_aplhabet=>"g", :url=>"http://www.rightmove.co.uk/uk-property-search-g.html"}, {:index_aplhabet=>"h", :url=>"http://www.rightmove.co.uk/uk-property-search-h.html"}, {:index_aplhabet=>"i-k", :url=>"http://www.rightmove.co.uk/uk-property-search-i-k.html"}, {:index_aplhabet=>"l", :url=>"http://www.rightmove.co.uk/uk-property-search-l.html"}, {:index_aplhabet=>"m-ne", :url=>"http://www.rightmove.co.uk/uk-property-search-m-ne.html"}, {:index_aplhabet=>"o-r", :url=>"http://www.rightmove.co.uk/uk-property-search-o-r.html"}, {:index_aplhabet=>"sc-so", :url=>"http://www.rightmove.co.uk/uk-property-search-sc-so.html"}, {:index_aplhabet=>"st-sw", :url=>"http://www.rightmove.co.uk/uk-property-search-st-sw.html"}, {:index_aplhabet=>"t-v", :url=>"http://www.rightmove.co.uk/uk-property-search-t-v.html"}, {:index_aplhabet=>"wa-we", :url=>"http://www.rightmove.co.uk/uk-property-search-wa-we.html"}, {:index_aplhabet=>"wi-wr", :url=>"http://www.rightmove.co.uk/uk-property-search-wi-wr.html"}, {:index_aplhabet=>"y", :url=>"http://www.rightmove.co.uk/uk-property-search-y.html"}]},
    {"london"=>[{:index_aplhabet=>"be-br", :url=>"http://www.rightmove.co.uk/london-property-search-be-br.html"}, {:index_aplhabet=>"c", :url=>"http://www.rightmove.co.uk/london-property-search-c.html"}, {:index_aplhabet=>"e-g", :url=>"http://www.rightmove.co.uk/london-property-search-e-g.html"}, {:index_aplhabet=>"hi-ho", :url=>"http://www.rightmove.co.uk/london-property-search-hi-ho.html"}, {:index_aplhabet=>"i-k", :url=>"http://www.rightmove.co.uk/london-property-search-i-k.html"}, {:index_aplhabet=>"l-m", :url=>"http://www.rightmove.co.uk/london-property-search-l-m.html"}, {:index_aplhabet=>"n-r", :url=>"http://www.rightmove.co.uk/london-property-search-n-r.html"}, {:index_aplhabet=>"s-t", :url=>"http://www.rightmove.co.uk/london-property-search-s-t.html"}, {:index_aplhabet=>"w", :url=>"http://www.rightmove.co.uk/london-property-search-w.html"}]}
    url = uk_london_index_aplhabets.first["united kingdom"][0][:url]
    page = HTTParty.get(url)
    nokogiri_page = Nokogiri::HTML(page)
    cities = []
    city_names = nokogiri_page.css("div.regionindex > h4")
    sub_city_names = nokogiri_page.css("div.regionindex > ul")
    city_names.size
    city_names.size.times do |n|
      sub_cities = []
      sub_city_names[n].css('a').each do |sub_city|
        sub_cities << sub_city.text.gsub("Property for sale in ", "").gsub(" ","-") if sub_city.text.include?("Property for sale in ")
      end
      cities << { city_names[n].css('a').first.text.gsub("Property for sale in ", "").gsub("(","").gsub(")","").gsub(" ","-") => sub_cities}
    end
    puts cities
  end

  # get_cities

  def self.scrape_properties_from_single_page(nokogiri_page, city, property_for, properties_per_page)
    properties_divs = nokogiri_page.css("div.l-searchResult.is-list")
    properties = []
    # if first property is featured property we will ignore it as it will be coverd while scraping others
    start = properties_divs[0].css("div.propertyCard-wrapper > div.propertyCard-moreInfo > div.propertyCard-moreInfoFeaturedTitle").text.downcase.include?('featured')? 1 : 0
    (0...properties_per_page).each do |n|
      id_from_rightmove = properties_divs[n].css("a.propertyCard-anchor").attribute('id').value.gsub("prop", "").strip
      property_link = BASE_URL + "/property-for-#{property_for}/property-#{id_from_rightmove}.html"
      image_url = "http:" + properties_divs[n].css("div.propertyCard-wrapper > div.propertyCard-images > a.propertyCard-img-link.aspect-3x2 > div.propertyCard-img > img").attribute('src').value
      price = properties_divs[n].css("div.propertyCard-wrapper > div.propertyCard-header > div.propertyCard-price > a.propertyCard-priceLink.propertyCard-salePrice > div.propertyCard-priceValue").text.strip
      price = (price =~ /\d/) ? ("£" + price.partition("£").last) : '-'
      description = properties_divs[n].css("div.propertyCard-wrapper > div.propertyCard-content > div.propertyCard-section > div.propertyCard-details > a.propertyCard-link > h2.propertyCard-title").text.strip.gsub(" for sale", "")
      address = properties_divs[n].css("div.propertyCard-wrapper > div.propertyCard-content > div.propertyCard-section > div.propertyCard-details > a.propertyCard-link > address.propertyCard-address > span").text.strip
      street = address.split(/#{city}/i).first.reverse.sub(',', '').reverse
      linked_on = properties_divs[n].css("div.propertyCard-wrapper > div.propertyCard-content > div.propertyCard-detailsFooter > div.propertyCard-branchSummary > span.propertyCard-branchSummary-addedOrReduced").text.strip.gsub("Added on ", "").gsub("Reduced on ", "")
      Property.create(id_from_rightmove: id_from_rightmove, property_link: property_link, image_url: image_url, price: price, description: description, address: address, street: street, property_for: property_for, city_or_town: city, linked_on: linked_on)
      begin
      rescue  
      end  
    end
    properties
  end


  def self.scrape_properties()

    cities = {"Aberdeen-County"=>["Aberdeen", "Aberdeen-Airport"]},
    {"Aberdeenshire"=>["Aboyne", "Ballater", "Banchory", "Banff", "Braemar", "Ellon", "Fraserburgh", "Huntly", "Inverurie", "Peterhead", "Stonehaven", "Turriff"]},
    {"Angus"=>["Arbroath", "Barry", "Brechin", "Carnoustie", "Forfar", "Kirriemuir", "Montrose"]},
    {"Argyll-and-Bute"=>["Appin", "Arrochar", "Campbeltown", "Cardross", "Cove", "Dunoon", "Helensburgh", "Inveraray", "Isle-Of-Bute", "Isle-Of-Islay", "Isle-Of-Tiree", "Kilcreggan", "Lochgilphead", "Loch-Lomond", "Luss", "Oban", "Rhu", "Rothesay", "Tarbert", "Tobermory"]},
    {"Bedfordshire"=>["Ampthill", "Arlesey", "Aspley-Guise", "Barton-Le-Clay", "Bedford", "Biddenham", "Biggleswade", "Bromham", "Caddington", "Clapham", "Clifton", "Clophill", "Cranfield", "Dunstable", "Eaton-Bray", "Flitwick", "Great-Barford", "Harlington", "Harrold", "Henlow", "Houghton-Regis", "Kempston", "Langford", "Leighton-Buzzard", "Linslade", "Luton", "Marston-Moretaine", "Maulden", "Oakley", "Potton", "Sandy", "Sharnbrook", "Shefford", "Shillington", "Silsoe", "Stotfold", "Toddington", "Turvey", "Woburn", "Wootton"]},
    {"Berkshire"=>["Ascot", "Binfield", "Bracknell", "Burghfield-Common", "Calcot", "Caversham", "Caversham-Heights", "Cippenham", "Colnbrook", "Cookham", "Crowthorne", "Datchet", "Earley", "Finchampstead", "Hermitage", "Hungerford", "Langley", "Lower-Earley", "Maidenhead", "Mortimer", "Newbury", "Old-Windsor", "Pangbourne", "Reading", "Sandhurst", "Shinfield", "Slough", "Sunningdale", "Sunninghill", "Thatcham", "Theale", "Tilehurst", "Twyford", "Warfield", "Wargrave", "Windsor", "Winnersh", "Wokingham", "Woodley", "Wraysbury"]}

    properties = []

    property_for = [ "sale", "rent"]

    puts 1
    url = BASE_URL + "/property-for-#{property_for[0]}/#{cities[0].keys[0]}.html"

    web_page = HTTParty.get(url)
    nokogiri_page = Nokogiri::HTML(web_page)

    locationIdentifier = nokogiri_page.css("div.l-container.l-filtersBar-container > input").attribute('value').value.gsub("^","%5E")

    properties_per_page = 24

    properties_found = nokogiri_page.css("div#searchHeader > span.searchHeader-resultCount").text.to_i
    
    pages = (nokogiri_page.css("div.searchHeader-title#searchHeader > span.searchHeader-resultCount").text.to_f/properties_per_page).ceil

    properties = scrape_properties_from_single_page(nokogiri_page, cities[0].keys[0].split('-').first, property_for[0], properties_per_page)

    (1...pages).each do|page|
      puts page+1
      new_url = BASE_URL + "/property-for-#{property_for[0]}/#{cities[0].keys[0]}.html?locationIdentifier=#{locationIdentifier}&index=#{page*24}"
      web_page = HTTParty.get(new_url)
      nokogiri_page = Nokogiri::HTML(web_page)
      properties_per_page = properties_found -(page*24) if (page+1) == pages
      properties += scrape_properties_from_single_page(nokogiri_page, cities[0].keys[0].split('-').first, property_for[0], properties_per_page)
    end

    puts properties

  end

# get_properties


  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |property|
        csv << property.attributes
      end
    end
  end

end
