class CronParser
  def initialize(cron)
    @cron = cron
  end

  def minute
    minutes = parsed_cron[0]
    minutes.tr(',', ' ')
  end

  private

  attr_reader :cron

  def parsed_cron
    cron.split(' ')
  end
end
