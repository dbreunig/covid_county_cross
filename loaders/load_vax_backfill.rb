require_relative '../db'

require 'csv'

# Clear the tables
StateVaccineStatus.dataset.delete
CountyVaccineStatus.dataset.delete

#
# State Records
#

# Load the input data
state_vax_records = CSV.foreach('loaders/source_data/state_vax_backfill.csv', headers: true).map(&:to_h)

# Load State Vaccination History
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
state_vax = state_vax_records.map { |h| h.slice(*state_keys) }
state_vax = state_vax.map { |h| h.values } # h.values_at(*state_keys)
StateVaccineStatus.dataset.import(
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
  state_vax)
puts "#{StateVaccineStatus.count} state vaccine statuses"
p StateVaccineStatus.first

#
# County Records
#

# Load the input data
county_vax_records = CSV.foreach('loaders/source_data/county_vax_backfill.csv', headers: true).map(&:to_h)
county_vax_records = county_vax_records.map { |h| h["FIPS"] = h["FIPS"].length < 5 ? "0#{h["FIPS"]}" : h["FIPS"]; h }

# Load County Vaccination History
county_keys      = [
  "FIPS", "Date",
  "Series_Complete_18Plus", "Series_Complete_18PlusPop_Pct", "Series_Complete_65Plus", "Series_Complete_65PlusPop_Pct",
  "Series_Complete_Yes", "Series_Complete_Pop_Pct", "Series_Complete_12Plus", "Series_Complete_12PlusPop_Pct",
  "Administered_Dose1_Recip", "Administered_Dose1_Recip_12Plus", "Administered_Dose1_Recip_18Plus", "Administered_Dose1_Recip_65Plus",
  "Administered_Dose1_Pop_Pct", "Administered_Dose1_Recip_12PlusPop_Pct", "Administered_Dose1_Recip_18PlusPop_Pct", "Administered_Dose1_Recip_65PlusPop_Pct"
]
county_vax = county_vax_records.map { |h| h.slice(*county_keys) }
county_vax = county_vax.map { |h| h.values } # h.values_at(*county_keys)
CountyVaccineStatus.dataset.import(
  [
    'county_id','date',
    'series_complete_18_plus','series_complete_18_plus_pop_pct','series_complete_65_plus','series_complete_65_plus_pop_pct',
    'series_complete','series_complete_pop_pct','series_complete_12_plus','series_complete_12_plus_pop_pct',
    'administered_dose_1_recip','administered_dose_1_recip_12_plus','administered_dose_1_recip_18_plus','administered_dose_1_recip_65_plus',
    'administered_dose_1_pop_pct','administered_dose_1_recip_12_plus_pop_pct','administered_dose_1_recip_18_plus_pop_pct','administered_dose_1_recip_65_plus_pop_pct'
  ], 
  county_vax)
puts "#{CountyVaccineStatus.count} county vaccine statuses"
p CountyVaccineStatus.first