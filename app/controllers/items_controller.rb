require 'open-uri'
require 'nokogiri'
require 'json'

class ItemsController < ApplicationController

  def new
    @item = Item.new
  end

  def create
    scrape_ikea

    @item = Item.new(name: scrape_ikea[:name], description: scrape_ikea[:description], price: scrape_ikea[:price], url: scrape_ikea[:url], src: scrape_ikea[:src])
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

  def netaporter
    url = 'https://api.net-a-porter.com/NAP/US/en/4/0/summaries/expand?pids=1006040'
    @image = "https://cache.net-a-porter.com/images/products/1006040/1006040_in_pp.jpg"
    user_serialized = open(url).read
    info = JSON.parse(user_serialized)
    @name = info['summaries'][0]['name']
    @price = info['summaries'][0]['price']['amount']
  end

  private

  def scrape_ikea
    @url = url_params[:url]
      html_file = open(@url).read
      html_doc = Nokogiri::HTML(html_file)
        name = html_doc.css('#name').text.split.join
        price = html_doc.css('#price1').text.split.join.gsub(/(\$|€)/,'').to_f
        src  = "http://www.ikea.com/" + html_doc.at('#productImg')['src']
        description = html_doc.css('#type').text.split.join
    attributes = {name: name, price: price, description: description, url: @url, src: src}
    return attributes
  end



  def url_params
    params.require(:item).permit(:url)
  end

  def update_params
    params.require(:item).permit(:user_price)
  end
end
