module EngineDatabases
  class ComponentNameCveCode
    def initialize(component_name:, represent_version:)
      @component_name = component_name
      @represent_version = represent_version
    end

    def call_chart()
      db_connection
      result = cve_chart cve_codes
      close_connection
      result
    end

    def call_list()
      db_connection
      result = cve_list cve_codes
      close_connection
      result
    end

    def call_codes
      db_connection
      result = cve_codes
      close_connection
      result
    end

    def call_checksums
      db_connection
      result = checksums
      close_connection
      result
    end

    private

    attr_reader :component_name, :represent_version, :processed_file, :security_cve, :security_cve_pkg, :security_cve_info

    def db_connection
      @processed_file = EngineDatabases::GetPlanet.new(scope: ProcessedFile).call()
      @security_cve = EngineDatabases::GetPlanet.new(scope: SecurityCve).call()
      @security_cve_pkg = EngineDatabases::GetPlanet.new(scope: SecurityCvePkg).call()
      @security_cve_info = EngineDatabases::GetPlanet.new(scope: SecurityCveInfo).call()
    end

    def cve_codes
      merged_codes = query_security_cve + query_security_cve_pkg
      merged_codes.collect(&:strip).uniq
    end

    def query_security_cve
      security_cve.where(checksum: checksums).collect(&:cve)
    end

    def query_security_cve_pkg
      security_cve_pkg.where(package: component_name, version: represent_version).collect(&:cve)
    end

    def cve_chart codes
      cve_info = security_cve_info.where(cve: codes).map{|cve| [cve.score, cve.pdate]}
      Securities::NvdChartMapper.new(cve_info: cve_info).call
    end

    def cve_list codes
      security_cve_info.where(cve: codes).order(:cve)
    end

    def checksums
      processed_file.where(package: component_name, version: represent_version).collect(&:checksum).uniq
    end

    def close_connection
      ActiveRecord::Base.remove_connection(processed_file)
      ActiveRecord::Base.remove_connection(security_cve)
      ActiveRecord::Base.remove_connection(security_cve_pkg)
      ActiveRecord::Base.remove_connection(security_cve_info)
    end
  end
end
