class CronParser
  def initialize(cron)
    @cron = cron
  end

  def minute
    input = parsed_cron[0]
    if input =~ /\*/
      minute_x = input[/(\d+)/].to_i
      minutes_in_hour = (0..59).select { |min| min.to_i.modulo(minute_x.to_i).zero? }
      return minutes_in_hour.join(' ')
    end

    input.tr(',', ' ')
  end

  private

  attr_reader :cron

  def parsed_cron
    cron.split(' ')
  end
end
