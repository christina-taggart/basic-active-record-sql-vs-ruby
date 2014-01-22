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

  def table_name
    "students"
  end

  # We say a record is "new" if it doesn't have a defined primary key in its
  # attributes
  def new_record?
    self[:id].nil?
  end

  # e.g., student['first_name'] #=> 'Steve'
  # def [](attribute)
  #   raise_error_if_invalid_attribute!(attribute)

  #   @attributes[attribute]
  # end

  # # e.g., student['first_name'] = 'Steve'
  # def []=(attribute, value)
  #   raise_error_if_invalid_attribute!(attribute)

  #   @attributes[attribute] = value
  # end

  def cohort
    Cohort.where('id = ?', self[:cohort_id]).first
  end

  def cohort=(cohort)
    self[:cohort_id] = cohort[:id]
    self.save
    cohort
  end
end
