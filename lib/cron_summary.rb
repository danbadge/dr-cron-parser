class CronSummary
  def initialize(minute:, hour:, day:, month:, year:)
    @minute_field = minute
    @hour_field = hour
    @day_field = day
    @month_field = month
    @year_field = year
  end

  def minute
    minute_field.summarise
  end

  def hour
    hour_field.summarise
  end

  def day
    day_field.summarise
  end

  def month
    month_field.summarise
  end

  def year
    year_field.summarise
  end

  private

  attr_reader :minute_field, :hour_field, :day_field, :month_field, :year_field
end
