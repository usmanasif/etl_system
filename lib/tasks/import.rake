require 'rake'

task :import, [:directory, :mapping_definition, :reporting_folder, :company_id] => [:environment] do |task, args|
  Mapping::Import.call!(args)
  puts 'Done!'
end
