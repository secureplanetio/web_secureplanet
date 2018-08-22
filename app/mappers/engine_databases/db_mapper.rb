module EngineDatabases
  class DbMapper
    def call(data)
      DbEntity.new.tap do |entity|
        entity.adapter  = 'postgresql'
        entity.host     = postgresql_host(data)
        entity.port     = postgresql_port(data)
        entity.username = postgresql_user(data)
        entity.password = postgresql_password(data)
        entity.database = postgresql_db(data)
      end
    end

    private

    def postgresql_host(data)
      data['dbconfig']['postgresql_host']
    end

    def postgresql_port(data)
      data['dbconfig']['postgresql_port']
    end

    def postgresql_user(data)
      data['dbconfig']['postgresql_user']
    end

    def postgresql_password(data)
      data['dbconfig']['postgresql_password']
    end

    def postgresql_db(data)
      data['dbconfig']['postgresql_db']
    end
  end
end
