class ProcessedFile < ActiveRecord::Base
  self.inheritance_column = "class_type"
  self.table_name = :processed_file
  self.abstract_class = true
end
