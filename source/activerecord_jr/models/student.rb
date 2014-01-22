class Student < Database::Model
  def self.all
    Database::Model.execute("SELECT * FROM students").map do |row|
      Student.new(row)
    end
  end

  def self.create(attributes)
    record = self.new(attributes)
    record.save

    record
  end

  def self.where(query, *args)
    Database::Model.execute("SELECT * FROM students WHERE #{query}", *args).map do |row|
      Student.new(row)
    end
  end

  def self.find(pk)
    self.where('id = ?', pk).first
  end

  self.attribute_names =  [:id, :cohort_id, :first_name, :last_name, :email,
                           :gender, :birthdate, :created_at, :updated_at]

  attr_reader :attributes, :old_attributes

  # e.g., Student.new(:id => 1, :first_name => 'Steve', :last_name => 'Rogers', ...)
  def initialize(attributes = {})
    super

    Student.attribute_names.each do |name|
      @attributes[name] = attributes[name]
    end

    @old_attributes = @attributes.dup
  end

  # We say a record is "new" if it doesn't have a defined primary key in its
  # attributes
  def new_record?
    self[:id].nil?
  end



  def cohort
    Cohort.where('id = ?', self[:cohort_id]).first
  end

  def cohort=(cohort)
    self[:cohort_id] = cohort[:id]
    self.save
    cohort
  end

  private

  def insert!
    self[:created_at] = DateTime.now
    self[:updated_at] = DateTime.now

    fields = self.attributes.keys
    values = self.attributes.values
    marks  = Array.new(fields.length) { '?' }.join(',')

    insert_sql = "INSERT INTO students (#{fields.join(',')}) VALUES (#{marks})"

    results = Database::Model.execute(insert_sql, *values)

    # This fetches the new primary key and updates this instance
    self[:id] = Database::Model.last_insert_row_id
    results
  end

  def update!
    self[:updated_at] = DateTime.now

    fields = self.attributes.keys
    values = self.attributes.values

    update_clause = fields.map { |field| "#{field} = ?" }.join(',')
    update_sql = "UPDATE students SET #{update_clause} WHERE id = ?"

    # We have to use the (potentially) old ID attribute in case the user has re-set it.
    Database::Model.execute(update_sql, *values, self.old_attributes[:id])
  end
end
