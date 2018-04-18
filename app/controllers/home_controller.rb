class HomeController < ApplicationController

  def index
    # uk_cities = 
    # london_cities = 
    @count = Property.all.count
    @properties = Property.page(params[:page]).per(10)
    # unless IndexAlphabet.all.count == 0
    #   @uk_indexes = IndexAlphabet.where(state_id: 1).all
    #   @london_indexes = IndexAlphabet.where(state_id: 2).all
    # end
  end

  def scrape_indexes
  end

  def scrape_cities
  end

  def scrape_properties
    count = Property.all.count
    if count <= 1500
      # Home.scrape_properties(params[:url])
      # new_count = Property.all.count
      # @diff = new_count - count
    else
    end
  end

  def download_xls
    @properties = Property.all
    respond_to do |format|
      format.html
      format.csv { send_data Property.all.to_csv }
      format.xls 
    end
  end

end