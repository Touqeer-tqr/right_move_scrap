Rails.application.routes.draw do
  root 'home#index'
  get 'index', to: 'home#index'
  get 'scrape_indexes', to: 'home#scrape_indexes'
  get 'scrape_cities', to: 'home#scrape_cities'
  get 'scrape_properties', to: 'home#scrape_properties'
  get 'download_xls', to: 'home#download_xls'
end
