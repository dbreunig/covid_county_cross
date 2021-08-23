require 'open-uri'
require 'csv'

require_relative '../db'

# Datasources
county_dex_url = "https://github.com/COVIDExposureIndices/COVIDExposureIndices/blob/master/dex_data/county_dex.csv?raw=true"
state_dex_url  = "https://github.com/COVIDExposureIndices/COVIDExposureIndices/blob/master/dex_data/state_dex.csv?raw=true"

csv = CSV.new(URI.open(state_dex_url), headers: true)
state_dex = csv.read.map(&:to_h)
state_dex.map! { |h| h.slice('state', 'date', 'dex', 'num_devices') }
state_dex.map!(&:values)
state_dex.map! do |r|
  r[0] = String(State.find(abbr: r[0]).fips) # Convert the abbr to fips
  r[1] = Date.strptime(r[1], '%Y-%m-%d')     # Format the date
  r[2] = r[2].to_f
  r[3] = r[3].to_i
  r
end
StateExposure.dataset.import(['state_id','date','dex','num_devices'], state_dex)
puts "#{StateExposure.count} state exposures"
p StateExposure.first

csv = CSV.new(URI.open(county_dex_url), headers: true)
county_dex = csv.read.map(&:to_h).map(&:values)
county_dex.map! do |r| 
  r[0] = r[0].length < 5 ? "0#{r[0]}" : r[0] # Fix the FIPS
  r[1] = Date.strptime(r[1], '%Y-%m-%d')     # Format the date
  r[2] = r[2].to_f
  r[3] = r[3].to_i
  r
end
CountyExposure.dataset.import(['county_id','date','dex','num_devices'], county_dex)
puts "#{CountyExposure.count} county exposures"
p CountyExposure.first