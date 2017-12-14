namespace :price_scraper do
  desc "Scrapeing prices for all listed Items"
  task scrape: :environment do
    SavePrice.new
  end
end
