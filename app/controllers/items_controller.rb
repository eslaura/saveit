require 'open-uri'
require 'nokogiri'
require 'json'

class ItemsController < ApplicationController

  def new
    @item = Item.new
  end

  def create
    scrape = scrape(url_params[:url])
    raise
    @item = Item.new(name: scrape[:name], description: scrape[:description], price: scrape[:price], url: scrape[:url], src: scrape[:src])
    @item.user = current_user

    @item.save

    redirect_to edit_item_path(@item)
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    @item.update(update_params)
    redirect_to user_dashboard_path
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to user_dashboard_path
  end

  def user_items
    @items = Item.where(user: current_user)
  end



  private

  def scrape(url)
    if url.include? "ikea"
      scrape_ikea
    elsif url.include? "net-a-porter"
      scrape_netaporter
    elsif url.include? "lululemon"
      scrape_lululemon
    end
  end

  def url_params
    params.require(:item).permit(:url)
  end

  def update_params
    params.require(:item).permit(:user_price)
  end

  def scrape_ikea
    url = url_params[:url]
    html_file = open(url).read
    html_doc = Nokogiri::HTML(html_file)
    name = html_doc.css('#name').text.split.join
    price = html_doc.css('#price1').text.split.join.gsub(/(\$|€)/,'').to_f
    src  = "http://www.ikea.com/" + html_doc.at('#productImg')['src']
    description = html_doc.css('#type').text.split.join
    attributes = {name: name, price: price, description: description, url: url, src: src}
    return attributes
  end

  def scrape_netaporter
    url = url_params[:url]
    product_id = url[/product\/\d*/].sub(/product\//, '')
    url = "https://api.net-a-porter.com/NAP/US/en/4/0/summaries/expand?pids=#{product_id}"
    src = "https://cache.net-a-porter.com/images/products/#{product_id}/#{product_id}_in_pp.jpg"
    user_serialized = open(url).read
    info = JSON.parse(user_serialized)
    name = info['summaries'][0]['name']
    price = info['summaries'][0]['price']['amount']
    attributes = {name: name, price: price, url: url, src: src, }
    return attributes
  end

  def scrape_lululemon
   url = "https://shop.lululemon.com/p/women-sports-bras/Energy-Bra-Nulux-JAC/_/prod8330193?color=31959"
    url_chunk = #TAKE ONLY (from the 'p' to before the ?)'p/women-sports-bras/Energy-Bra-Nulux-JAC/_/prod8330193'
    api = "https://shop.lululemon.com/api/#{url_chunk}"
    user_serialized = open(api).read
    info = JSON.parse(user_serialized)
    @name = info['data']['attributes']['product-summary']['product-name']
    @price = info['data']['attributes']['product-summary']['list-price']
    @description = info['data']['attributes']['product-attributes']['product-content-fabric'][0]['fabricPurposes']
    @category = info['data']['attributes']['product-summary']['product-category']
    @url = info['data']['attributes']['product-summary']['product-site-map-pdp-url']
    @src = info['data']['attributes']['product-carousel'][0]['image-info'][0]
    @color = info['data']['attributes']['product-carousel'][0]['swatch-image']
  end
end

