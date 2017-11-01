require_relative 'cron_summary'
require_relative 'fields'
require_relative 'errors'

class CronParser
  def parse(cron)
    parsed_cron = cron.split(' ')

    raise InvalidFormatError, 'Cron is invalid' if parsed_cron.length < 5

    minute = Minute.parse!(parsed_cron[0])
    hour = Hour.parse!(parsed_cron[1])
    day_of_month = DayOfMonth.parse!(parsed_cron[2])
    month = Month.parse!(parsed_cron[3])
    day_of_week = DayOfWeek.parse!(parsed_cron[4])

    CronSummary.new(
      :minute => minute,
      :hour => hour,
      :day_of_month => day_of_month,
      :month => month,
      :day_of_week => day_of_week
    )
  end
end
