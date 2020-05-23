require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'faker'
end

require 'date'
require 'faker'

EMPLOYEES_CSV_PATH = './out/employees.csv'.freeze
NUM_EMPLOYEES = 1_000_000

def generate_employees_data(rows)
  (1..rows).to_a.map { |id|
    [
      id,
      rand(50) + 1,
      %Q("#{Faker::Name.first_name}"),
      %Q("#{Faker::Name.last_name}"),
      %Q("#{Faker::Date.birthday(min_age: 18, max_age: 65).iso8601}"),
      %Q("#{Faker::PhoneNumber.cell_phone}")
    ].join(',')
  }.join("\n")
end

File.open(EMPLOYEES_CSV_PATH, 'w') do |file|
  file.write(generate_employees_data(NUM_EMPLOYEES))
end
