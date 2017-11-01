require_relative 'errors'

class Field
  def initialize(value:, lower_bound:, upper_bound:, field_name:)
    @value = value
    @lower_bound = lower_bound
    @upper_bound = upper_bound
    @field_name = field_name
  end

  def parse!
    if value =~ /\*\/(\d+)/
      value_every_x = value[/(\d+)/]
      raise InvalidFormatError, "#{field_name} is in an invalid format" unless valid_single_value?(value_every_x)
      return
    elsif value == '*'
      return
    end

    value.split(',').each do |v|
      raise InvalidFormatError, "#{field_name} is in an invalid format" unless valid_single_value?(v)
    end
  end

  def summarise
    if value =~ /\*\/(\d+)/
      value_every_x = value[/(\d+)/]
      values = (0..59).select { |v| v.to_i.modulo(value_every_x.to_i).zero? }
      return values.join(' ')
    elsif value == '*'
      return (0..59).to_a.join(' ')
    end

    value.split(',').map(&:to_i).join(' ')
  end

  private

  def valid_single_value?(value)
    number = Integer(value)
    number <= upper_bound && number >= lower_bound
  rescue => _error
    false
  end

  attr_reader :value, :lower_bound, :upper_bound, :field_name
end
