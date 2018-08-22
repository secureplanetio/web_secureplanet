module EngineDatabases
  class DbEntity
    include Virtus.model
    include ActiveModel::Serialization
    extend ActiveModel::Naming

    attribute :adapter, String
    attribute :host, String
    attribute :port, String
    attribute :username, String
    attribute :password, String
    attribute :database, String
  end
end
