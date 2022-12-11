# RedisRecord
#
# RedisRecord is a base class for all models that are stored in Redis.
# It provides a simple interface for creating and retrieving records.
class RedisRecord
  SCHEMA = []
  IDENTIFIER_NAME = ""

  attr_reader(*self::SCHEMA.push(:id))

  def initialize(params)
    self.class::SCHEMA.push(:id).each do |attribute|
      instance_variable_set("@#{attribute}", params[attribute])
    end
  end

  class << self
    # This method is called when a class inherits from RedisRecord. This allows the
    # class to inherit the schema and identifier name from RedisSchema.
    def inherited(child)
      indentifier = child.name.underscore
      schema = RedisSchema.const_get(indentifier.upcase)

      child.const_set(:SCHEMA, schema)
      child.const_set(:IDENTIFIER_NAME, indentifier.downcase)

      schema.each do |attribute|
        attr_reader attribute
      end
    end

    # This method is used to find a record by its id. If the record is found, it builds
    # a new instance of the class and returns it. If the record is not found, it returns nil.
    def find(id)
      return if id.nil?

      store = fetch_store(id)

      build(id, store) if store.present?
    end

    # This method is used to create a new record in Redis. It takes an id,
    # a hash of attributes, and an optional expiration time. If an expiration
    # time is not provided, the record will not expire.
    def create(id, params, expire_in: nil)
      return if id.nil? || params.nil?

      store = build_store(params)

      $redis.set("#{self::IDENTIFIER_NAME}-#{id}", store, ex: expire_in)

      build(id, store)
    end

    private

    # This method is used to fetch a record from Redis. It takes an id and returns
    # the raw JSON string if it exists.
    def fetch_store(id)
      $redis.get("#{self::IDENTIFIER_NAME}-#{id}")
    end

    # This method builds a new instance of the class. It takes an id and the JSON string
    # that is stored in Redis and returns a new instance of the class.
    def build(id, store)
      new(JSON.parse(store).symbolize_keys.merge(id: id))
    end

    # This method builds a JSON string from a hash of attributes.
    def build_store(params = {})
      self::SCHEMA.map do |attribute|
        [attribute.to_s, params[attribute]]
      end.to_h.to_json
    end
  end
end
