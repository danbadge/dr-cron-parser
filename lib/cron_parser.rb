require_relative 'cron_summary'

class CronParser
  def parse(cron)
    @cron = cron
    validate_minute!

    CronSummary.new(cron)
  end

  def validate_minute!
    input = parsed_cron[0]

    if input =~ /\*\/(\d+)/
      minute_x = input[/(\d+)/]
      raise StandardError, 'Minute is in an invalid format' unless valid_minute?(minute_x)
    end

    input.split(',').each do |min|
      raise StandardError, 'Minute is in an invalid format' unless valid_minute?(min)
    end
  end

  private

  attr_reader :cron

  def parsed_cron
    cron.split(' ')
  end

  def valid_minute?(input)
    number = Integer(input)
    number <= 59 && number >= 0
  rescue => _error
    false
  end
end
