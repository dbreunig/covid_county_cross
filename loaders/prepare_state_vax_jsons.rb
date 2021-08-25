require 'json'
require 'csv'

# Load the data first so we can assemble the header from the data
headers = []
records = []
Dir.glob('loaders/source_data/state-vax-jsons/*.json').each do |path|
  # Load
  file = File.read(path)
  next if file.length == 0
  json = JSON.parse(file)

  json["vaccination_data"].each do |v|
    headers << v.keys
    headers = headers.flatten.uniq
    records << v
  end
end

# Get state fips
state_mapping = {} # abbr: fips
CSV.foreach("loaders/source_data/states.csv", headers: true) do |row|
  state_mapping[row["abbr"]] = row["fips"]
end

# Change location from abbreviation to fips. If nil, don't use
records = records.map do |record|
  record["Location"] = state_mapping[record["Location"]]
  record
end
records = records.select { |r| r["Location"] }

CSV.open("loaders/source_data/state_vax_backfill.csv", "wb") do |csv|
  csv << headers
  records.each do |r|
    csv << headers.map { |k| r[k] }
  end
end