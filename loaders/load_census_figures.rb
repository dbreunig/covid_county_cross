# Data Source
# https://www.census.gov/programs-surveys/popest/data/data-sets.html

## Note: this isn't that much to walk through (one line per county and state),
## and we're updating records not inserting, so we're going to parse one line at a time.

# Meta to Extract
state_key = "STATE"
county_key = "COUNTY"

## Regions for County & State
region_key = "REGION"
regions = {
  1 => "Northeast",
  2 => "Midwest",
  3 => "South",
  4 => "West"
}

## Divisions for each County & State
division_key = "DIVISION"
divisions = {
  1 => "New England",
  2 => "Middle Atlantic",
  3 => "East North Central",
  4 => "West North Central",
  5 => "South Atlantic",
  6 => "East South Central",
  7 => "West South Central",
  8 => "Mountain",
  9 => "Pacific"
}

## 2019 Population estimate
population_key = "POPESTIMATE2019"

# Load the data
require 'csv'
require_relative '../db'

CSV.foreach('loaders/source_data/census_counties_2019.csv', headers: true) do |row|
  # Extract the needed data
  division  = row[division_key].to_i
  region    = row[region_key].to_i
  pop       = row[population_key]
  state     = row[state_key].length == 1 ? "0#{row[state_key]}" : row[state_key]
  county    = row[county_key]
  # Fix county code by appending zeroes when needed
  case county.length
  when 1
    county = "00#{county}"
  when 2
    county = "0#{county}"
  end
  fips = "#{state}#{county}" # create the fips key

  # Find or create the regions or division
  the_region    = Region.find_or_create(key: region, name: regions[region])
  the_division  = Division.find_or_create(key: division, name: divisions[division])

  # Load the data
  case row["SUMLEV"]
  when "40" # Load State
    the_state = State.find(fips: state)
    the_state.region      = the_region
    the_state.division    = the_division
    the_state.population  = pop
    the_state.save
  when "50" # Load County
    the_county = County.find(fips: fips)
    the_county.region      = the_region
    the_county.division    = the_division
    the_county.population  = pop
    the_county.save
  end
end

puts "#{Region.count} regions"
p Region.first
puts "#{Division.count} divisions"
p Division.first