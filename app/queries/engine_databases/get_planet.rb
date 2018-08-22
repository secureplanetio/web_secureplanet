module EngineDatabases
  class GetPlanet
    def initialize(scope:, db_config: DbRepo.new())
      @scope = scope
      @db_config = db_config
    end

    def call()
      connect_engine_db
      scope
    end

    private

    attr_reader :scope, :db_config

    def connect_engine_db
      scope.establish_connection(db_config.load_config().to_hash)
    end
  end
end
