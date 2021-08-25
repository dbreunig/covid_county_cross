# COVID County Cross

This pipeline for creating, loading, and updating a SQLite database is designed to facilliate analysis regarding COVID in the United States, at the county level. Clone the repo and build your own dataset or download the SQLite database and go to town.

In addition to adding additional sources of data (listed below), I'll be adding documentation, including detailed descriptions of each table and examples of usage over the coming days.

If you want to play with the data now and aren't familiar with SQLite, I'd recommend [downloading the covid_counties.db file](https://drive.google.com/file/d/1vPAB8TL27LD3hz-ytq19ZgywsBNxM-BN/view?usp=sharing) and playing around with [Datasette](https://datasette.io/). (I'll be hosting the database somewhere a little more resilient shortly.)

If you have any questions or comments, reach out. If you use this project to create something, also let me know. I'd be excited to plug your work here.

## Datasources

- [CDC Vaccine Hesitancy Survey](https://data.cdc.gov/stories/s/cnd2-a6zw)
- [US Census](https://www.census.gov/programs-surveys/popest/data/data-sets.html): The estimated 2019 population figures are used for state and county population information.
- [New York Times COVID-19 Github Repository](https://github.com/nytimes/covid-19-data): The NYT does an admirable job of sourcing and normalizing case and death figures.
- [COVID Exposure Indices](https://github.com/COVIDExposureIndices/COVIDExposureIndices): "These indices are produced by Victor Couture, Jonathan Dingel, Allison Green, Jessie Handbury, and Kevin Williams, with assistance from Hayden Parsley, Serena Xu, and Shih Hsuan Hsu. They are derived from anonymized, aggregated smartphone movement data provided by PlaceIQ."

## Data Sources to Come

- Vaccination rates:
- County & State Shapefiles as WKT columns (currently in `loaders/source_data`)
- [Hospitalization rates and other figures](https://healthdata.gov/Hospital/COVID-19-Reported-Patient-Impact-and-Hospital-Capa/anag-cw7u)
- [LEX](https://github.com/COVIDExposureIndices/COVIDExposureIndices), estimating travel rates between counties and states

## Notes

- Generating the dataset requires SQLite 3.33.0 or greater.

## Next Steps

- Refactor County Model: incorporate hesitancy, ethnicity, vulnerability
- Make vax pipeline one pipeline: Get data from github repo, expand it, load it
- Shapefiles