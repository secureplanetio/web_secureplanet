class SecurityCve< ActiveRecord::Base
  self.inheritance_column = "class_type"
  self.table_name = :security_cve
  self.abstract_class = true
end
