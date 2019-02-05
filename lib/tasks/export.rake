require 'rake'

task :export, [:export_folder, :mapping_definition, :company_id] => [:environment] do |task, args|
  Mapping::Export.call!(args)
  puts 'Done!'
end
