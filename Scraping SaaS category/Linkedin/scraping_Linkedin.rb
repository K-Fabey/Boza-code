require 'open-uri'
require 'nokogiri'
require "csv"

# This fontion is not working because we are not able
# to access Linkedin with a simple URI.Open commande


def add_company_info
  employee_file_path = 'Test_scraping.csv'
  refacto_file_path = 'Refacto_responsable IT.csv'

  CSV.foreach(employee_file_path, headers: :first_row) do |employee|
    employee_url = employee['profileUrl']

    html_content = URI.open(employee_url).read
    doc = Nokogiri::HTML(html_content)
    puts doc

    doc.search('.pvs-entity').first do |bloc|
      bloc.search('a').first do |details|
        link = details.attribute(href).value
      end
      bloc.search('.t-14 .t-normal').first do |details|
        name = details.text
      end
      employee = employee + [name, link]

      CSV.open(refacto_file_path, "a") do |csv|
        csv << employee
        puts 'Refactorization done'
      end

    end
  end
end

add_company_info
