require 'open-uri'
require 'nokogiri'
require 'json'

class SavePrice

  def scrape_price
    Item.all.each do |item|
      if item.url.include? "ikea"
        price = 9 # scrape_ikea_price(item.url)
        Price.create(item_id: item.id, price: price)
        price_change(item, price)
      elsif item.url.include? "lululemon"
        price = 9 #scrape_lululemon_price(item.url_api)
        Price.create(item_id: item.id, price: price)
        price_change(item, price)
      elsif item.url.include? "newlook"
        price = 9 #scrape_newlook_price(item.url_api)
        Price.create(item_id: item.id, price: price)
        price_change(item, price)
      end
    end
  end

  private

  def price_change(item, price)
    if item.user_price
      if item.price != price && price <= item.user_price
        notification = Notification.new(old_price: item.price, new_price: price)
        item.update(price: price)
        notification.item = item
        notification.save
      elsif item.price != price
        item.update(price: price)
      end
    end
  end

  def scrape_ikea_price(url)
    html_file = open(url).read
    html_doc = Nokogiri::HTML(html_file)
    price = html_doc.css('#price1').text.split.join.gsub(/(\$|€)/,'').to_f
    return price
  end

  def scrape_lululemon_price(url)
    user_serialized = open(url).read
    info = JSON.parse(user_serialized)
    price = info['data']['attributes']['product-summary']['list-price'].to_f.round(2)
    return price
  end

  def scrape_newlook_price(url)
    user_serialized = open(url).read
    info = JSON.parse(user_serialized)
    price = info['data']['price']['value'].to_f.round(2)
    return price
  end
end
