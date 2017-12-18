require 'open-uri'
require 'nokogiri'
require 'json'

class ItemsController < ApplicationController
# skip_before_action :authenticate_registration!, only: [:home]

  def new
    @item = Item.new
  end

  def create
    scrape = ItemScraper.new.scrape(url_params[:url])
    if scrape == false
      render 'user_items'
    else
      @item = Item.new(name: scrape[:name], description: scrape[:description], price: scrape[:price], url: scrape[:url], src: scrape[:src], url_api: scrape[:url_api], original_store: scrape[:store])
      @item.user = current_user
      @item.save
      Price.create(item_id: @item.id, price: @item.price)

      redirect_to user_dashboard_path
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
    @item = Item.new
    @items = Item.where(user: current_user)
  end

  def wish_list
    @item = Item.new

    @items = Item.where(user: current_user)
  end

  private

  def url_params
    params.require(:item).permit(:url)
  end

  def update_params
    params.require(:item).permit(:user_price)
  end
end

