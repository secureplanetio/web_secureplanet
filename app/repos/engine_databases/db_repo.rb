module EngineDatabases
  class DbRepo
    def initialize(adapter = InifileAdapter.new)
      @adapter = adapter
    end

    def load_config()
      data = load_data()
      map_data(data)
    end

    private

    attr_reader :adapter

    def map_data(data, mapper = DbMapper.new)
      mapper.call(data)
    end

    def load_data()
      adapter.load_data(scan_db_file_path())
    end

    def scan_db_file_path()
      "#{Dir.home}/#{Settings.path.project_root}/#{Settings.path.custom}/engine.config"
    end
  end
end
