require 'json'
path = File.join(File.dirname(__FILE__), '../data/products.json')
file = File.read(path)
products_hash = JSON.parse(file)

brand_names = []

# Print today's date
puts ""
puts "___________________________________________"
puts ""
puts "Date: " + Time.now.strftime("%m/%d/%Y")
puts "___________________________________________"
puts "                     _            _       "
puts "                    | |          | |      "
puts " _ __  _ __ ___   __| |_   _  ___| |_ ___ "
puts "| '_ \\| '__/ _ \\ / _` | | | |/ __| __/ __|"
puts "| |_) | | | (_) | (_| | |_| | (__| |_\\__ \\"
puts "| .__/|_|  \\___/ \\__,_|\\__,_|\\___|\\__|___/"
puts "| |                                       "
puts "|_|                                       "
puts ""
puts "___________________________________________"
puts ""
# For each product in the data set:
products_hash["items"].each do |toy|

  brand_names.push(toy["brand"]) unless brand_names.include? toy["brand"] #setting up brands in the array for brands portion of the report

# Print the name of the toy
  puts "Toy name: #{toy["title"]}"   
    
# Print the retail price of the toy
  retail_price=toy["full-price"].to_f #.to_f needed to calculate the average discount
  puts "Retail Price: $ #{retail_price}"  

# Calculate and print the total number of purchases 
  tot_purchases = toy["purchases"].length #totals the number of purchases made
  puts "Total number of purchases: #{tot_purchases}" 

# Calculate and print the total amount of sales
  tot_sales = 0.00
  toy["purchases"].each do |purchase|
    tot_sales = tot_sales + purchase["price"]
  end
  puts "Total Sales: $ #{tot_sales}"

# Calculate and print the average price the toy sold for
  avg_price = tot_sales / tot_purchases
  puts "Average Price: $ #{avg_price}"

# Calculate and print the average discount (% or $) based off the average sales price
  avg_discount = retail_price - avg_price
  puts "Average Discount: $ #{avg_discount}"
  puts


  puts "___________________________________________"
  puts ""
end

puts "___________________________________________"
puts ""  
	puts " _                         _     "
	puts "| |                       | |    "
	puts "| |__  _ __ __ _ _ __   __| |___ "
	puts "| '_ \\| '__/ _` | '_ \\ / _` / __|"
	puts "| |_) | | | (_| | | | | (_| \\__ \\"
	puts "|_.__/|_|  \\__,_|_| |_|\\__,_|___/"
	puts
puts "" 
puts "___________________________________________"
puts ""  

# For each brand in the data set:
brand_names.each do |name|

# Print the name of the brand
  puts "Brand Name: #{name}"

#select by brand to divide things up by brand 
  brand_math = products_hash["items"].select { |item| item["brand"] == name }
  
  #determine number of toys for each brand, the length of the 'select' array is the number of toys.
  brand_number_of_toys = brand_math.length

  # set up some variables for calculating things 
  brands_in_stock = 0
  brand_price_total = 0
  brand_revenue_gross = 0
  average_brand_price = 0
  brand_shipping_total = 0
  brand_revenue_total = 0
  
  brand_math.each do |stuff|
    # Count the number of the brand's toys we stock
    brands_in_stock = brands_in_stock + stuff["stock"]
       
    #Calculate the average price of the brand's toys
    brand_price_total = brand_price_total + stuff["full-price"].to_f
    average_brand_price = brand_price_total / brand_number_of_toys
      # loop over stuff to pull out the 2nd dimension purchases
      stuff["purchases"].each do |whee|
        brand_revenue_gross = brand_revenue_gross + whee["price"].to_f
        brand_shipping_total = brand_shipping_total + whee["shipping"].to_f
        brand_revenue_total = brand_revenue_gross - brand_shipping_total
      end
    
    
  end
   
  # print the number of the brand's toys we stock
  puts "  Number of brand's toys in Stock: #{brands_in_stock}"
  
  # Calculate and print the average price of the brand's toys
  puts "  Average brand toys Price: $ #{average_brand_price.round(2)}"
  
  # Calculate and print the total revenue of all the brand's toy sales combined
  # Total revenue minus shipping
  puts "  Total brand toy Revenue: $ #{brand_revenue_total.round(2)}"
  puts
  

puts "___________________________________________"
puts ""
end

