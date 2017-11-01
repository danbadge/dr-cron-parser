require_relative 'cron_summary'
require_relative 'field'

class CronParser
  def parse(cron)
    parsed_cron = cron.split(' ')
    minute = Minute.parse!(parsed_cron[0])
    hour = Hour.parse!(parsed_cron[1])

    CronSummary.new(
      :minute => minute,
      :hour => hour,
      :day => nil,
      :month => nil,
      :year => nil
    )
  end
end

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
