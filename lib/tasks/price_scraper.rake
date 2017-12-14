namespace :price_scraper do
  desc "Scraping prices for all listed Items"
  task scrape: :environment do
    puts "Start scraping"
    SavePrice.new.scrape_price
    puts "Scraping done"
  end
end
