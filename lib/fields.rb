require_relative 'field'

class Minute
  def self.parse!(value)
    field = Field.new(
      :value => value,
      :lower_bound => 0,
      :upper_bound => 59,
      :field_name => 'Minute'
    )

    field.parse!
    field
  end
end

class Hour
  def self.parse!(value)
    field = Field.new(
      :value => value,
      :lower_bound => 0,
      :upper_bound => 23,
      :field_name => 'Hour'
    )

    field.parse!
    field
  end
end

class DayOfMonth
  def self.parse!(value)
    field = Field.new(
      :value => value,
      :lower_bound => 1,
      :upper_bound => 31,
      :field_name => 'Day of the month'
    )

    field.parse!
    field
  end
end

class Month
  def self.parse!(value)
    field = Field.new(
      :value => value,
      :lower_bound => 1,
      :upper_bound => 12,
      :field_name => 'Month'
    )

    field.parse!
    field
  end
end

class DayOfWeek
  def self.parse!(value)
    field = Field.new(
      :value => value,
      :lower_bound => 1,
      :upper_bound => 7,
      :field_name => 'Day of the week'
    )

    field.parse!
    field
  end
end
