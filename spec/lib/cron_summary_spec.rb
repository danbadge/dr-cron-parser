require 'spec_helper'
require 'cron_summary'

describe CronSummary do
  let(:minute) { double(:minute, :summarise => 'minute summary') }
  let(:hour) { double(:hour, :summarise => 'hour summary') }
  let(:day_of_month) { double(:day_of_month, :summarise => 'day of month summary') }
  let(:month) { double(:month, :summarise => 'month summary') }
  let(:day_of_week) { double(:day_of_week, :summarise => 'day of the week summary') }

  let(:cron_summary) do
    CronSummary.new(
      :minute => minute,
      :hour => hour,
      :day_of_month => day_of_month,
      :month => month,
      :day_of_week => day_of_week
    )
  end

  context 'when retrieving a minute summary' do
    it 'returns the correct result' do
      expect(cron_summary.minute).to eq('minute summary')
    end
  end

  context 'when retrieving a hour summary' do
    it 'returns the correct result' do
      expect(cron_summary.hour).to eq('hour summary')
    end
  end

  context 'when retrieving a day summary' do
    it 'returns the correct result' do
      expect(cron_summary.day_of_month).to eq('day of month summary')
    end
  end

  context 'when retrieving a month summary' do
    it 'returns the correct result' do
      expect(cron_summary.month).to eq('month summary')
    end
  end

  context 'when retrieving a day of the week summary' do
    it 'returns the correct result' do
      expect(cron_summary.day_of_week).to eq('day of the week summary')
    end
  end
end
