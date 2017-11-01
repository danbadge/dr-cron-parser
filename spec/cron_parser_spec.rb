require 'spec_helper'
require 'cron_parser'
require 'cron_summary'

describe CronParser do
  let(:parse_cron) { described_class.new.parse(cron) }
  let(:cron_summary) { CronSummary.new(cron) }

  describe 'given user wants a minute breakdown' do
    context 'when input is string' do
      let(:cron) { 'what-is-this * * * *' }

      it 'throws an exception' do
        expect { parse_cron }.to raise_error(StandardError, 'Minute is in an invalid format')
      end
    end

    context 'when input contains a string' do
      let(:cron) { '10,wat * * * *' }

      it 'throws an exception' do
        expect { parse_cron }.to raise_error(StandardError, 'Minute is in an invalid format')
      end
    end

    context 'when input is too large' do
      let(:cron) { '555 * * * *' }

      it 'throws an exception' do
        expect { parse_cron }.to raise_error(StandardError, 'Minute is in an invalid format')
      end
    end

    context 'when input is negative' do
      let(:cron) { '-1 * * * *' }

      it 'throws an exception' do
        expect { parse_cron }.to raise_error(StandardError, 'Minute is in an invalid format')
      end
    end

    context 'when input is 0' do
      let(:cron) { '0 * * * *' }

      it 'returns 0' do
        expect(cron_summary.minute).to eq('0')
      end
    end

    context 'when input is 15' do
      let(:cron) { '15 * * * *' }

      it 'returns 15' do
        expect(cron_summary.minute).to eq('15')
      end
    end

    context 'when input is 15, 32 and 48' do
      let(:cron) { '15,32,48 * * * *' }

      it 'returns 15 32 48' do
        expect(cron_summary.minute).to eq('15 32 48')
      end
    end

    context 'when input is */15' do
      let(:cron) { '*/15 * * * *' }

      it 'returns every minute in the hour it will run' do
        expect(cron_summary.minute).to eq('0 15 30 45')
      end
    end

    context 'when input is */7' do
      let(:cron) { '*/3 * * * *' }

      it 'returns every minute in the hour it will run' do
        expect(cron_summary.minute).to eq('0 3 6 9 12 15 18 21 24 27 30 33 36 39 42 45 48 51 54 57')
      end
    end

    context 'when input is */7' do
      let(:cron) { '*/38 * * * *' }

      it 'returns every minute in the hour it will run' do
        expect(cron_summary.minute).to eq('0 38')
      end
    end

    context 'when input is *' do
      let(:cron) { '* * * * *' }

      it 'returns every minute in the hour' do
        expect(cron_summary.minute).to eq('0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59')
      end
    end
  end
end
