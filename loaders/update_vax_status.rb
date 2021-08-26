require 'open-uri'
require 'json'

require_relative '../db'

# Datasources
counties_url = 'https://raw.githubusercontent.com/dbreunig/cdc-covid-vaccine-history/main/counties.json'
states_url   = 'https://raw.githubusercontent.com/dbreunig/cdc-covid-vaccine-history/main/vax.json'

#
# States
#

# What we want from each state record
state_keys      = [
  "Location", "Date",
  "Doses_Distributed", "Doses_Administered", "Dist_Per_100K", "Admin_Per_100K",
  "Administered_Moderna", "Administered_Pfizer", "Administered_Janssen", "Administered_Unk_Manuf",
  "Administered_Dose1_Recip", "Administered_Dose1_Pop_Pct", "Administered_Dose2_Pop_Pct", "Administered_Dose1_Recip_18Plus", "Administered_Dose1_Recip_18PlusPop_Pct",
  "Administered_18Plus", "Admin_Per_100k_18Plus", "Administered_Dose1_Recip_65Plus", "Administered_Dose1_Recip_65PlusPop_Pct",
  "Administered_65Plus", "Admin_Per_100k_65Plus", "Administered_Dose2_Recip", "Administered_Dose2_Recip_18Plus",
  "Administered_Dose2_Recip_18PlusPop_Pct", 
  "Series_Complete_Moderna", "Series_Complete_Pfizer", "Series_Complete_Janssen", "Series_Complete_Unk_Manuf",
  "Series_Complete_Yes", "Series_Complete_Pop_Pct", "Series_Complete_18Plus", "Series_Complete_18PlusPop_Pct",
  "Series_Complete_65Plus", "Series_Complete_65PlusPop_Pct", "Administered_12Plus", "Admin_Per_100k_12Plus",
  "Administered_Dose1_Recip_12Plus", "Administered_Dose1_Recip_12PlusPop_Pct", "Administered_Dose2_Recip_12Plus",
  "Administered_Dose2_Recip_12PlusPop_Pct", "Series_Complete_12Plus", "Series_Complete_12PlusPop_Pct"
]

# Get the data
state_vax = JSON.parse URI.open(states_url).read
run_id    = VaccineRun.find_or_create(id: state_vax['runid'])

# Load if new run
unless run_id.states_loaded
  puts "New run found."
  state_vax['vaccination_data'].each do |r|
    # Get the insert values
    record = r.values_at(*state_keys)
    
    # Get the state
    the_state = State.find(abbr: r["Location"])
    next unless the_state # Don't worry about LTC, etc
    record[0] = the_state.fips

    # Insert
    StateVaccineStatus.dataset.insert(
      [
        "state_id", "date",
        "doses_distributed", "doses_administered", "dist_per_100k", "admin_per_100k",
        "administered_moderna", "administered_pfizer", "administered_janssen", "administered_unk_manf",
        "administered_dose_1_recip", "administered_dose_1_pop_pct", "administered_dose_2_pop_pct", "administered_dose_1_recip_18_plus", "administered_dose_1_recip_18_plus_pop_pct",
        "administered_18_plus", "administered_per_100k_18_plus", "administered_dose_1_recip_65_plus", "administered_dose_1_recip_65_plus_pop_pct",
        "administered_65_plus", "administered_per_100k_65_plus", "administered_dose_2_recip", "administered_dose_2_recip_18_plus",
        "administered_dose_2_recip_18_plus_pop_pct", 
        "series_complete_moderna", "series_complete_pfizer", "series_complete_janssen", "series_complete_unk_manuf",
        "series_complete", "series_complete_pop_pct", "series_complete_18_plus", "series_complete_18_plus_pop_pct",
        "series_complete_65_plus", "series_complete_65_plus_pop_pct", "administered_12_plus", "administered_per_100k_12_plus",
        "administered_dose_1_recip_12_plus", "administered_dose_1_recip_12_plus_pop_pct", "administered_dose_2_recip_12_plus",
        "administered_dose_2_recip_12_plus_pop_pct", "series_complete_12_plus", "series_complete_12_plus_pop_pct"
      ], 
      record
    )
  end
  run_id.states_loaded = true;
  run_id.save
  puts "State update for run #{run_id.id} complete."
else
  puts "Run exists for states"
end

#
# Counties
#

# What we want from each counties record
county_keys      = [
  "FIPS", "Date",
  "Series_Complete_18Plus", "Series_Complete_18PlusPop_Pct", "Series_Complete_65Plus", "Series_Complete_65PlusPop_Pct",
  "Series_Complete_Yes", "Series_Complete_Pop_Pct", "Series_Complete_12Plus", "Series_Complete_12PlusPop_Pct",
  "Administered_Dose1_Recip", "Administered_Dose1_Recip_12Plus", "Administered_Dose1_Recip_18Plus", "Administered_Dose1_Recip_65Plus",
  "Administered_Dose1_Pop_Pct", "Administered_Dose1_Recip_12PlusPop_Pct", "Administered_Dose1_Recip_18PlusPop_Pct", "Administered_Dose1_Recip_65PlusPop_Pct"
]

# Get the data
county_vax  = JSON.parse URI.open(counties_url).read
run_id      = VaccineRun.find_or_create(id: county_vax['runid'])

# Load if new run
unless run_id.counties_loaded
  puts "New run found."
  county_vax['vaccination_county_condensed_data'].each do |r|
    # Get the insert values
    record = r.values_at(*county_keys)
    next unless County[r["FIPS"]] # Ensure county exists
    
    # Insert
    CountyVaccineStatus.dataset.insert(
      [
        'county_id','date',
        'series_complete_18_plus','series_complete_18_plus_pop_pct','series_complete_65_plus','series_complete_65_plus_pop_pct',
        'series_complete','series_complete_pop_pct','series_complete_12_plus','series_complete_12_plus_pop_pct',
        'administered_dose_1_recip','administered_dose_1_recip_12_plus','administered_dose_1_recip_18_plus','administered_dose_1_recip_65_plus',
        'administered_dose_1_pop_pct','administered_dose_1_recip_12_plus_pop_pct','administered_dose_1_recip_18_plus_pop_pct','administered_dose_1_recip_65_plus_pop_pct'
      ], 
      record
    )
  end
  run_id.counties_loaded = true;
  run_id.save
  puts "County update for run #{run_id.id} complete."
else
  puts "Run exists for counties"
end