require 'open-uri'
require 'nokogiri'
require "csv"



def category_list
  html_content = URI.open('https://financesonline.com/browse-all-software-categories/').read
  doc = Nokogiri::HTML(html_content)

  csvpath = "category_list.csv"

  CSV.open(csvpath, "wb") do |csv|
    csv << ["Category Name", "Link"]

    doc.search('.row').each do |bloc|
      bloc.search('li').each do |item|
        bloc.search('a').each do |line|
          # puts "#{line.text} => #{line.attribute("href").value} "
          csv << [line.text, line.attribute("href").value]
        end
      end

    end

  end
  puts "Category_list csv file ok"

end

# category_list

def tool_per_category_list

  category_file_path = "category_list.csv"
  tools_file_path = "tools_per_category_list.csv"


  CSV.foreach(category_file_path, headers: :first_row) do |category|
    # puts "#{category['Category Name']} >>>> #{category['Link']}"

    # Open the link and start scraping
    category_link = category['Link']
    html_content = URI.open("#{category_link}").read
    doc = Nokogiri::HTML(html_content)

    # Fillin the csv file with all the tools' name of the category, scraped on the given link
    tools_list = []
    tools_list[0] =category['Category Name']
    doc.search('.category__rank').each do |boxes|
      boxes.search('.category__rank-info').each do |box|
        box.search('h4').each do |item|
          item.search('a').each do |line|
            # puts line.attribute("title").value
            tools_list << line.attribute("title").value
          end
        end
      end
    end

    # save tools list in the csv file
    CSV.open(tools_file_path, "a") do |csv|
      csv << tools_list
      puts "List of tools for #{category['Category Name']} => Done"
    end

  end

end

# action to be executed

tool_per_category_list
