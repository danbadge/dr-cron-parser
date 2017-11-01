require_relative 'cron_summary'

class CronParser
  class InvalidFormatError < StandardError; end

  def parse(cron)
    @parsed_cron = cron.split(' ')
    Minute.new.validate!(parsed_cron[0])
    Hour.new.validate!(parsed_cron[1])

    CronSummary.new(parsed_cron)
  end

  private

  attr_reader :parsed_cron
end

class Hour
  def validate!(value)
    validator = FieldValidator.new(
      :value => value,
      :lower_bound => 0,
      :upper_bound => 23,
      :field_name => 'Hour'
    )

    validator.validate!
  end
end

class Minute
  def validate!(value)
    validator = FieldValidator.new(
      :value => value,
      :lower_bound => 0,
      :upper_bound => 59,
      :field_name => 'Minute'
    )

    validator.validate!
  end
end

class FieldValidator
  def initialize(value:, lower_bound:, upper_bound:, field_name:)
    @value = value
    @lower_bound = lower_bound
    @upper_bound = upper_bound
    @field_name = field_name
  end

  def validate!
    if value =~ /\*\/(\d+)/
      value_every_x = value[/(\d+)/]
      raise CronParser::InvalidFormatError, "#{field_name} is in an invalid format" unless valid_single_value?(value_every_x)
      return
    elsif value == '*'
      return
    end

    value.split(',').each do |v|
      raise CronParser::InvalidFormatError, "#{field_name} is in an invalid format" unless valid_single_value?(v)
    end
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
