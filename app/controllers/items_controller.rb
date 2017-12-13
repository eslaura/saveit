require 'open-uri'
require 'nokogiri'
require 'json'

class ItemsController < ApplicationController

  def new
    @item = Item.new
  end

  def create
    scrape = scrape(url_params[:url])
    if scrape == false
      render 'user_items'
    else
      @item = Item.new(name: scrape[:name], description: scrape[:description], price: scrape[:price], url: scrape[:url], src: scrape[:src])
      @item.user = current_user

      @item.save

      redirect_to edit_item_path(@item)
    end
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
    @items = Item.where(user: current_user)
    if url.include? "ikea"
      scrape_ikea
    elsif url.include? "net-a-porter"
      scrape_netaporter
    elsif url.include? "lululemon"
      scrape_lululemon
    elsif url.include? "newlook"
      scrape_newlook
    else
      return false
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

  def scrape_lululemon
    url = url_params[:url]
    url_chunk = url[/p\/.*\?/].chomp("?")
    api = "https://shop.lululemon.com/api/#{url_chunk}"
    user_serialized = open(api).read
    info = JSON.parse(user_serialized)
    name = info['data']['attributes']['product-summary']['product-name']
    price = info['data']['attributes']['product-summary']['list-price']
    category = info['data']['attributes']['product-summary']['product-category']
    url = info['data']['attributes']['product-summary']['product-site-map-pdp-url']
    src = info['data']['attributes']['product-carousel'][0]['image-info'][0]
    color = info['data']['attributes']['product-carousel'][0]['swatch-image']
    description = info['data']['attributes']['product-attributes']['product-content-fabric'][0]['fabricPurposes'].join(",")
    attributes = {name: name, price: price, url: url, src: src, description: description}
    return attributes
  end

  def scrape_newlook
    url = url_params[:url]
    product_id = url[/p\/\d+/].sub("p/","")
    url = "http://www.newlook.com/uk/json/product/productDetails.json?productCode=#{product_id}"
      user_serialized = open(url).read
      info = JSON.parse(user_serialized)
      name = info['data']['name']
      price = info['data']['price']['value']
      src = info["data"]["primaryImage"]['url']
    attributes = {name: name, price: price, url: url, src: src}
    return attributes
  end

  # https://www.net-a-porter.com/es/en/product/994243/stella_mccartney/bryce-melton-wool-blend-coat
  # https://api.net-a-porter.com/NAP/ES/en/4/0/summaries/expand?pids=899702
  # def scrape_netaporter
  #   url = url_params[:url]
  #   product_id = url[/product\/\d*/].sub(/product\//, '')
  #   url = "https://api.net-a-porter.com/NAP/US/en/4/0/summaries/expand?pids=#{product_id}"
  #   src = "https://cache.net-a-porter.com/images/products/#{product_id}/#{product_id}_in_pp.jpg"
  #   user_serialized = open(url).read
  #   info = JSON.parse(user_serialized)
  #   name = info['summaries'][0]['name']
  #   price = info['summaries'][0]['price']['amount']
  #   attributes = {name: name, price: price, url: url, src: src}
  #   return attributes
  # end
end

