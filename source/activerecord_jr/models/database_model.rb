require 'sqlite3'

module Database
  class InvalidAttributeError < StandardError;end
  class NotConnectedError < StandardError;end

  class Model
    def self.inherited(klass)
    end

    def self.connection
      @connection
    end

    def self.create(attributes)
      record = self.new(attributes)
      record.save

      record
    end

    def self.filename
      @filename
    end

    def self.database=(filename)
      @filename = filename.to_s
      @connection = SQLite3::Database.new(@filename)

      # Return the results as a Hash of field/value pairs
      # instead of an Array of values
      @connection.results_as_hash  = true

      # Automatically translate data from database into
      # reasonably appropriate Ruby objects
      @connection.type_translation = true
    end

    def self.attribute_names
      @attribute_names
    end

    def self.attribute_names=(attribute_names)
      @attribute_names = attribute_names
    end

    # Input looks like, e.g.,
    # execute("SELECT * FROM students WHERE id = ?", 1)
    # Returns an Array of Hashes (key/value pairs)
    def self.execute(query, *args)
      raise NotConnectedError, "You are not connected to a database." unless connected?

      prepared_args = args.map { |arg| prepare_value(arg) }
      Database::Model.connection.execute(query, *prepared_args)
    end

    def self.last_insert_row_id
      Database::Model.connection.last_insert_row_id
    end

    def self.connected?
      !self.connection.nil?
    end

    def self.find(pk)
      self.where('id = ?', pk).first
    end

    def initialize(attributes = {})
      attributes.symbolize_keys!
      raise_error_if_invalid_attribute!(attributes.keys)
      # This defines the value even if it's not present in attributes
      @attributes = {}
      @attribute_names.each do |name|
        @attributes[name] = attributes[name]
      end
      @old_attributes = @attributes.dup
    end

    # We say a record is "new" if it doesn't have a defined primary key in its
    # attributes
    def new_record?
      self[:id].nil?
    end

    def raise_error_if_invalid_attribute!(attributes)
      # This guarantees that attributes is an array, so we can call both:
      #   raise_error_if_invalid_attribute!("id")
      # and
      #   raise_error_if_invalid_attribute!(["id", "name"])
      Array(attributes).each do |attribute|
        unless valid_attribute?(attribute)
          raise InvalidAttributeError, "Invalid attribute for #{self.class}: #{attribute}"
        end
      end
    end

    # e.g., student['first_name'] #=> 'Steve'
    def [](attribute)
      raise_error_if_invalid_attribute!(attribute)

      @attributes[attribute]
    end

      # e.g., student['first_name'] = 'Steve'
    def []=(attribute, value)
      raise_error_if_invalid_attribute!(attribute)

      @attributes[attribute] = value
    end

    def save
      if new_record?
        results = insert!
      else
        results = update!
      end

      # When we save, remove changes between new and old attributes
      @old_attributes = @attributes.dup

      results
    end

    def to_s
      attribute_str = self.attributes.map { |key, val| "#{key}: #{val.inspect}" }.join(', ')
      "#<#{self.class} #{attribute_str}>"
    end

    def valid_attribute?(attribute)
      self.class.attribute_names.include? attribute
    end

    private
    def self.prepare_value(value)
      case value
      when Time, DateTime, Date
        value.to_s
      else
        value
      end
    end
  end
end
