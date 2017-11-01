require_relative 'cron_summary'

class CronParser
  class InvalidFormatError < StandardError; end

  def parse(cron)
    @parsed_cron = cron.split(' ')
    validate_minute!

    CronSummary.new(parsed_cron)
  end

  private

  attr_reader :parsed_cron

  def validate_minute!
    minute_input = parsed_cron[0]

    if minute_input =~ /\*\/(\d+)/
      minute_x = minute_input[/(\d+)/]
      raise InvalidFormatError, 'Minute is in an invalid format' unless valid_minute?(minute_x)
    elsif minute_input =~ /\*/
      return
    end

    minute_input.split(',').each do |min|
      raise InvalidFormatError, 'Minute is in an invalid format' unless valid_minute?(min)
    end
  end

  def valid_minute?(input)
    number = Integer(input)
    number <= 59 && number >= 0
  rescue => _error
    false
  end
end
