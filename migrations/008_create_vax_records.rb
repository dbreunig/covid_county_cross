Sequel.migration do
  change do
    create_table(:county_vaccine_statuses) do
      primary_key :id
      Date :date, null: false
      Integer :series_complete_18_plus # Series_Complete_18Plus
      Float   :series_complete_18_plus_pop_pct # Series_Complete_18PlusPop_Pct
      Integer :series_complete_65_plus # Series_Complete_65Plus
      Float   :series_complete_65_plus_pop_pct # Series_Complete_65PlusPop_Pct
      Integer :series_complete # Series_Complete_Yes
      Float   :series_complete_pop_pct # Series_Complete_Pop_Pct
      Integer :series_complete_12_plus # Series_Complete_12Plus
      Float   :series_complete_12_plus_pop_pct # Series_Complete_12PlusPop_Pct
      Integer :administered_dose_1_recip # Administered_Dose1_Recip
      Integer :administered_dose_1_recip_12_plus # Administered_Dose1_Recip_12Plus
      Integer :administered_dose_1_recip_18_plus # Administered_Dose1_Recip_18Plus
      Integer :administered_dose_1_recip_65_plus # Administered_Dose1_Recip_65Plus
      Float   :administered_dose_1_pop_pct # Administered_Dose1_Pop_Pct
      Float   :administered_dose_1_recip_12_plus_pop_pct # Administered_Dose1_Recip_12PlusPop_Pct
      Float   :administered_dose_1_recip_18_plus_pop_pct # Administered_Dose1_Recip_18PlusPop_Pct
      Float   :administered_dose_1_recip_65_plus_pop_pct # Administered_Dose1_Recip_65PlusPop_Pct
      foreign_key :county_id, :counties, type: 'varchar(5)'
      index [:county_id, :date]
    end
    create_table(:state_vaccine_statuses) do
      primary_key :id
      Date :date, null: false # Date
      Integer :doses_distributed, null: false # Doses_Distributed
      Integer :doses_administered, null: false # Doses_Administered
      Integer :dist_per_100k, null: false # Dist_Per_100K
      Integer :admin_per_100k, null: false # Admin_Per_100K
      Integer :administered_moderna, null: false # Administered_Moderna
      Integer :administered_pfizer, null: false # Administered_Pfizer
      Integer :administered_janssen, null: false # Administered_Janssen
      Integer :administered_unk_manf, null: false # Administered_Unk_Manuf
      Integer :administered_dose_1_recip, null: false # Administered_Dose1_Recip
      Float   :administered_dose_1_pop_pct, null: false # Administered_Dose1_Pop_Pct
      Float   :administered_dose_2_pop_pct, null: false # Administered_Dose2_Pop_Pct
      Integer :administered_dose_1_recip_18_plus, null: false # Administered_Dose1_Recip_18Plus
      Float   :administered_dose_1_recip_18_plus_pop_pct, null: false # Administered_Dose1_Recip_18PlusPop_Pct
      Integer :administered_18_plus, null: false # Administered_18Plus
      Integer :administered_per_100k_18_plus, null: false # Admin_Per_100k_18Plus
      Integer :administered_dose_1_recip_65_plus # Administered_Dose1_Recip_65Plus
      Float   :administered_dose_1_recip_65_plus_pop_pct # Administered_Dose1_Recip_65PlusPop_Pct
      Integer :administered_65_plus # Administered_65Plus
      Integer :administered_per_100k_65_plus # Admin_Per_100k_65Plus
      Integer :administered_dose_2_recip, null: false # Administered_Dose2_Recip
      Integer :administered_dose_2_recip_18_plus, null: false # Administered_Dose2_Recip_18Plus
      Integer :administered_dose_2_recip_18_plus_pop_pct, null: false # Administered_Dose2_Recip_18PlusPop_Pct
      Integer :series_complete_moderna, null: false # Series_Complete_Moderna
      Integer :series_complete_pfizer, null: false # Series_Complete_Pfizer
      Integer :series_complete_janssen, null: false # Series_Complete_Janssen
      Integer :series_complete_unk_manuf, null: false # Series_Complete_Unk_Manuf
      Integer :series_complete # Series_Complete_Yes
      Float   :series_complete_pop_pct # Series_Complete_Pop_Pct
      Integer :series_complete_18_plus # Series_Complete_18Plus
      Float   :series_complete_18_plus_pop_pct # Series_Complete_18PlusPop_Pct
      Integer :series_complete_65_plus # Series_Complete_65Plus
      Float   :series_complete_65_plus_pop_pct # Series_Complete_65PlusPop_Pct
      Integer :administered_12_plus # Administered_12Plus
      Integer :administered_per_100k_12_plus # Admin_Per_100k_12Plus
      Integer :administered_dose_1_recip_12_plus # Administered_Dose1_Recip_12Plus
      Float   :administered_dose_1_recip_12_plus_pop_pct # Administered_Dose1_Recip_12PlusPop_Pct
      Integer :administered_dose_2_recip_12_plus # Administered_Dose2_Recip_12Plus
      Float   :administered_dose_2_recip_12_plus_pop_pct # Administered_Dose2_Recip_12PlusPop_Pct
      Integer :series_complete_12_plus # Series_Complete_12Plus
      Float   :series_complete_12_plus_pop_pct # Series_Complete_12PlusPop_Pct
      foreign_key :state_id, :states, type: 'varchar(2)'  # Location
      index [:state_id, :date]
    end
  end
end