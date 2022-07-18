require 'open-uri'
require 'nokogiri'
require "csv"


def tools_list
  html_content = URI.open('https://www.datamation.com/cloud/saas-companies/').read
  doc = Nokogiri::HTML(html_content)

  csvpath = "tools_list.csv"

  CSV.open(csvpath, "wb") do |csv|
    csv << ["Tool Name", "Link"]

    doc.search('#article-content').each do |bloc|
      bloc.search('h3').each do |item|
        csv << [item.text]
      end
    end
  end
  puts "Tools_list csv file ok"
end

tools_list
