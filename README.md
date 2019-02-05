# Features
- Implemented complete internal db structure as per our requirements.
- Implemented the mappings for different entities as per our requirements. `app/entities` containts all the mappings for specified entities inherited from `Entity` where the common code logic is placed.
- Implemented `Import` and `Export` services under `Mapping` module in `app/services` that handles the logic that which mapping entity should be used/triggered.
- Implemented two `rake tasks` just to `call` `Mapping::Import` or `Mapping::Export` services.
- Implemented `thread_mattr_accessor` to set `company_id` to handle required flows around the specified `company`. If we don't have any company related to the given `company_id` then I take `Company.first`.
- I have used `reference_id` column to track the `id` of an external record. (This can be same for two different external sources that can be handled using some different flags i.e source name etc)

------------

### Command Line Scripts (Rake Tasks)
- **Import**
command:`rake 'import[<input_directory>, <mapping_definition>, <reporting_folder>, <company_id>]'`
e.g`rake 'import[csv_files_1, csv_mapping_1, csv_files_1_reports, 1]'`

- **Export**
command:`rake 'export[<export_files_folder>, <mapping_definition>, <company_id>]`'
e.g`rake 'export[csv_export_files_1, csv_mapping_1, 1]'`

------------

### Tracking Procedure
- I have set three different types of statuses when we import data.
`not_changed` -> if record is already mapped in our internal db.
`updated` -> if record is updated in the external db and we successfully update the record in our internal db.
`created` -> if record is freshly inserted in our internal db.

------------
### Reporting File Example (created by our system)
| Changes had been done  |   | | |
| ------------ | ------------ |
| reference_id | name  | email | Status |
| 11 | Usman  | usman@gmail.com | not_changed
| 66 | Johnson Baby | johnson@gmail.com | updated |
| 88 | Mojo Jojo | jojo@gmail.com | created
