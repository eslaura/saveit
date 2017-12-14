namespace :price_scraper do
  desc "Scraping prices for all listed Items"
  task scrape: :environment do
    SavePrice.new
  end
end
