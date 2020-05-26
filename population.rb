require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'faker'
end

require 'date'
require 'faker'
require 'fileutils'

def generate_employees_data(rows, employments)
  (1..rows).to_a.map { |id|
    employments[id]  = rand(50) + 1

    [
      id,
      employments[id],
      %Q("#{Faker::Name.first_name}"),
      %Q("#{Faker::Name.last_name}"),
      %Q("#{Faker::Date.birthday(min_age: 18, max_age: 65).iso8601}"),
      %Q("#{Faker::PhoneNumber.cell_phone}")
    ].join(',')
  }.join("\n")
end

def generate_sales_data(employee_rows, employments)
  sales_count = 1

  (1..employee_rows).to_a.map { |employee_id|
    num_sales = rand(5) + 1
    sales_of_employee = []

    num_sales.times do
      eur_value = rand(10..1000)

      sales_of_employee << [
        sales_count,
        employee_id,
        employments[employee_id],
        rand(50) + 1,
        eur_value,
        rand(5) + 1,
        %Q("#{Faker::Date.backward(days: 100).iso8601}")
      ].join(',')

      sales_count += 1
    end

    sales_of_employee.join("\n")
  }.join("\n")
end

OUTPUT_DIR_PATH = 'out'.freeze
EMPLOYEES_CSV_PATH = "#{OUTPUT_DIR_PATH}/employees.csv".freeze
SALES_CSV_PATH = "#{OUTPUT_DIR_PATH}/sales.csv".freeze
NUM_EMPLOYEES = 100_000

FileUtils.mkdir_p(OUTPUT_DIR_PATH)

employments = {}

File.open(EMPLOYEES_CSV_PATH, 'w') do |file|
  file.write(generate_employees_data(NUM_EMPLOYEES, employments))
end

File.open(SALES_CSV_PATH, 'w') do |file|
  file.write(generate_sales_data(NUM_EMPLOYEES, employments))
end
