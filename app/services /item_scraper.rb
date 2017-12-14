class ItemScraper

  def scrape(url)
    if url.include? "ikea"
      scrape_ikea(url)
    elsif url.include? "lululemon"
      scrape_lululemon(url)
    elsif url.include? "newlook"
      scrape_newlook(url)
    else
      return false
    end
  end

  private

  def scrape_ikea(url)
    html_file = open(url).read
    html_doc = Nokogiri::HTML(html_file)
    name = html_doc.css('#name').text.split.join
    price = html_doc.css('#price1').text.split.join.gsub(/(\$|€)/,'').to_f
    src  = "http://www.ikea.com/" + html_doc.at('#productImg')['src']
    description = html_doc.css('#type').text.split.join
    attributes = {name: name, price: price, description: description, url: url, src: src}
    return attributes
  end

  def scrape_lululemon(url)
    url_chunk = url[/p\/.*\?/].chomp("?")
    url_api = "https://shop.lululemon.com/api/#{url_chunk}"
    user_serialized = open(url_api).read
    info = JSON.parse(user_serialized)
    name = info['data']['attributes']['product-summary']['product-name']
    price = info['data']['attributes']['product-summary']['list-price']
    category = info['data']['attributes']['product-summary']['product-category']
    src = info['data']['attributes']['product-carousel'][0]['image-info'][0]
    color = info['data']['attributes']['product-carousel'][0]['swatch-image']
    description = info['data']['attributes']['product-attributes']['product-content-fabric'][0]['fabricPurposes'].join(",")
    attributes = {name: name, price: price, url_api: url_api, src: src, description: description, url: url}
    return attributes
  end

  def scrape_newlook(url)
    product_id = url[/p\/\d+/].sub("p/","")
    url_api = "http://www.newlook.com/de/json/product/productDetails.json?productCode=#{product_id}"
    user_serialized = open(url_api).read
    info = JSON.parse(user_serialized)
    name = info['data']['name']
    price = info['data']['price']['value']
    src = info["data"]["primaryImage"]['url']
    attributes = {name: name, price: price, url_api: url_api, src: src, url: url}
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
