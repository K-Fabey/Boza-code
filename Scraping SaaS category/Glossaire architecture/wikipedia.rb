require 'open-uri'
require 'nokogiri'
require "csv"


def scraping

  html_content = URI.open("https://fr.wikipedia.org/wiki/Glossaire_de_l%27architecture#:~:text=Architecte%20%3A%20ma%C3%AEtre%20de%20conception%20et,(d'un%20fronton).").read
  doc = Nokogiri::HTML(html_content)

  csvpath = "extract.csv"

  CSV.open(csvpath, "wb") do |csv|
    # csv << ["Name", "Definition" ,"Link"]
    csv << ["Definition" ,"Link"]

    doc.search('.mw-parser-output').each do |paragraph|
      puts "bloc trouvée"

      paragraph.search('ul').each do |bloc|

        bloc.search('li').each do |item|
          puts "ligne trouvée"

          definition = item.text
          # link = "https://fr.wikipedia.org/" + item.attribute("href").value
          csv << [ definition]

          bloc.search('a').first do |line|
            # puts "#{line.text} => #{line.attribute("href").value} "
            link = "#{https://fr.wikipedia.org}" line.attribute("href").value"
          end
        end
      end


    end

  end


end

scraping
