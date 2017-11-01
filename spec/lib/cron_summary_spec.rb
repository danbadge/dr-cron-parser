require 'spec_helper'
require 'cron_summary'

describe CronSummary do
  let(:minute) { double(:minute, :summarise => 'minute summary') }
  let(:hour) { double(:hour, :summarise => 'hour summary') }
  let(:day) { double(:day, :summarise => 'day summary') }
  let(:month) { double(:month, :summarise => 'month summary') }
  let(:year) { double(:year, :summarise => 'year summary') }

  let(:cron_summary) do
    CronSummary.new(
      :minute => minute,
      :hour => hour,
      :day => day,
      :month => month,
      :year => year
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
      expect(cron_summary.day).to eq('day summary')
    end
  end

  context 'when retrieving a month summary' do
    it 'returns the correct result' do
      expect(cron_summary.month).to eq('month summary')
    end
  end

  context 'when retrieving a year summary' do
    it 'returns the correct result' do
      expect(cron_summary.year).to eq('year summary')
    end
  end
end
