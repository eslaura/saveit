require 'open-uri'
require 'nokogiri'
require 'json'

class SavePrice

  def scrape_price
    Item.all.each do |item|
      if item.url.include? "ikea"
        price = scrape_ikea_price(item.url)
        Price.create(item_id: item.id, price: price)
        item.update(price: price) if item.price != price
      elsif item.url.include? "lululemon"
        price = scrape_lululemon_price(item.url)
        Price.create(item_id: item.id, price: price)
        item.update(price: price) if item.price != price
      elsif item.url.include? "newlook"
        price = scrape_newlook_price(item.url)
        Price.create(item_id: item.id, price: price)
        item.update(price: price) if item.price != price
      end
    end
  end

  private

  def scrape_ikea_price(url)
    html_file = open(url).read
    html_doc = Nokogiri::HTML(html_file)
    price = html_doc.css('#price1').text.split.join.gsub(/(\$|€)/,'').to_f
    return price
  end

  def scrape_lululemon_price(url)
    user_serialized = open(url).read
    info = JSON.parse(user_serialized)
    price = info['data']['attributes']['product-summary']['list-price']
    return price
  end

  def scrape_newlook_price(url)
    user_serialized = open(url).read
    info = JSON.parse(user_serialized)
    price = info['data']['price']['value']
    return price
  end
end