require_relative '../db'

require 'csv'

# Clear the tables
County.dataset.delete
State.dataset.delete

# Load States
states = CSV.foreach('loaders/source_data/states.csv', headers: true).map(&:to_h)
State.dataset.multi_insert(states)
puts "#{State.count} states"
p State.first

# Load Counties
counties = CSV.foreach('loaders/source_data/counties.csv', headers: true).map(&:to_h)
counties.map { |c| c.delete('county_code') }
County.dataset.multi_insert(counties)
puts "#{County.count} counties"
p County.first
