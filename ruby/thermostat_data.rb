require 'pg'
require_relative './database_connection'

DatabaseConnection.setup('thermostat_data')

class Thermostat
  attr_reader :id, :current_city, :temperature

  def initialize(id, current_city, temperature)
    @id = id
    @current_city = current_city
    @temperature = temperature
  end

  def self.save(options)
    result = DatabaseConnection.query("INSERT INTO temp_log (current_city, temperature) VALUES('#{options[:current_city]}', '#{options[:temperature]}') RETURNING id, current_city, temperature;")
    Thermostat.new(result[0]['id'], result[0]['current_city'], result[0]['temperature'])
  end

  def self.latest
    result = DatabaseConnection.query("SELECT id, current_city, temperature FROM temp_log WHERE id = (SELECT MAX(id) FROM temp_log);")
    result.map { |entry| Thermostat.new(entry['id'], entry['current_city'], entry['temperature']) }
  end

end
