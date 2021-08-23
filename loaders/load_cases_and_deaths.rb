require 'open-uri'
require 'csv'

require_relative '../db'

# Datasources
counties_url = 'https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv'
# date,county,state,fips,cases,deaths
states_url   = 'https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-states.csv'

# Load states
csv = CSV.new(URI.open(states_url), headers: true)
state_cases = csv.read.map(&:to_h)
state_cases.map! { |h| h.slice('date','fips','cases','deaths')}
state_cases.map!(&:values)
state_cases.map! do |r| 
  next unless r[1] # Some fips codes are missing
  next if r[1] == "78" # Virgin Islands
  next if r[1] == "69" # Virgin Islands
  next if r[1] == "66" # Virgin Islands

  r[0] = Date.strptime(r[0], '%Y-%m-%d')     # Format the date
  r[1] = r[1].length < 2 ? "0#{r[1]}" : r[1]  # Fix the FIPS
  r[2] = r[2].to_i
  r[3] = r[3].to_i
  r
end
StateCase.dataset.import(['date','state_id','cases','deaths'], state_cases.compact)
puts "#{StateCase.count} state cases"
p StateCase.first

# Load counties
csv = CSV.new(URI.open(counties_url), headers: true)
county_cases = csv.read.map(&:to_h)
county_cases.map! { |h| h.slice('date','fips','cases','deaths')}
county_cases.map!(&:values)
county_cases.map! do |r| 
  next unless r[1] # Some fips codes are missing
  next if r[1][0..1] == '78'
  next if r[1][0..1] == '66'
  next if r[1][0..1] == '69'
  next if r[1] == "02997" # A multicounty area in alaska.
  next if r[1] == "02998" # An out of state area in alaska
  r[0] = Date.strptime(r[0], '%Y-%m-%d')     # Format the date
  r[1] = r[1].length < 5 ? "0#{r[1]}" : r[1]  # Fix the FIPS
  r[2] = r[2].to_i
  r[3] = r[3].to_i
  r
end
county_cases.filter! { |v| v && v.count == 4 }
# county_cases.each do |c|
#   p c
#   CountyCase.dataset.import(['date','county_id','cases','deaths'], [c])
# end
CountyCase.dataset.import(['date','county_id','cases','deaths'], county_cases)
puts "#{CountyCase.count} county cases"
p CountyCase.first