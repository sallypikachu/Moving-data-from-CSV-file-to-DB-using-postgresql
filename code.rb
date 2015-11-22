require 'csv'
require 'pry'

#createdb ingredients

require "pg"

def db_connection
  begin
    connection = PG.connect(dbname: "ingredients")
    yield(connection)
  ensure
    connection.close
  end
end

# db_connection do |conn|
#   conn.exec("CREATE TABLE ingredient(
#   id SERIAL PRIMARY KEY,
#   food varchar(100));")
# end

array_of_array = []
CSV.foreach('ingredients.csv') do |row|
  binding.pry
  ingredient = row.to_a
  array_of_array << ingredient
end

array_of_array.each do |array|
  db_connection do |conn|
    conn.exec("INSERT INTO ingredient (id, food) VALUES (#{array[0]}, '#{array[1]}');")
  end
end
