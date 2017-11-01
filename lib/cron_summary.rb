class CronSummary
  def initialize(cron)
    @cron = cron
  end

  def minute
    input = parsed_cron[0]

    if input =~ /\*\/(\d+)/
      minute_x = input[/(\d+)/]
      minutes_in_hour = (0..59).select { |min| min.to_i.modulo(minute_x.to_i).zero? }
      return minutes_in_hour.join(' ')
    elsif input =~ /\*/
      return (0..59).to_a.join(' ')
    end

    minutes = input.split(',').map do |min|
      min.to_i
    end

    minutes.join(' ')
  end

  private

  attr_reader :cron

  def parsed_cron
    cron.split(' ')
  end
end
