require 'json'
require 'csv'

# Load the data first so we can assemble the header from the data
headers = []
records = []
Dir.glob('loaders/source_data/county-vax-jsons/*.json').each do |path|
  # Load
  file = File.read(path)
  next if file.length == 0
  json = JSON.parse(file)

  json["vaccination_county_condensed_data"].each do |v|
    headers << v.keys
    headers = headers.flatten.uniq
    records << v
  end
end

# Get valid county fips
valid_fips = []
CSV.foreach("loaders/source_data/counties.csv", headers: true) do |row|
  valid_fips << row["fips"]
end

# Filter to valid fips
records = records.select { |r| valid_fips.include?(r["FIPS"]) }

# Output
CSV.open("loaders/source_data/county_vax_backfill.csv", "wb") do |csv|
  csv << headers
  records.each do |r|
    csv << headers.map { |k| r[k] }
  end
end