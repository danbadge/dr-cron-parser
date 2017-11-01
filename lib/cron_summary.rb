class CronSummary
  def initialize(minute:, hour:, day_of_month:, month:, day_of_week:)
    @minute_field = minute
    @hour_field = hour
    @day_of_month_field = day_of_month
    @month_field = month
    @day_of_week_field = day_of_week
  end

  def minute
    minute_field.summarise
  end

  def hour
    hour_field.summarise
  end

  def day_of_month
    day_of_month_field.summarise
  end

  def month
    month_field.summarise
  end

  def day_of_week
    day_of_week_field.summarise
  end

  private

  attr_reader :minute_field, :hour_field, :day_of_month_field, :month_field, :day_of_week_field
end
