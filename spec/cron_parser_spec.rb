require 'spec_helper'
require 'cron_parser'

describe CronParser do
  let(:cron_parser) { described_class.new(cron) }

  describe 'given user wants a minute breakdown' do
    context 'when input is 0' do
      let(:cron) { '0 * * * *' }

      it 'returns 0' do
        expect(cron_parser.minute).to eq('0')
      end
    end

    context 'when input is 15' do
      let(:cron) { '15 * * * *' }

      it 'returns 15' do
        expect(cron_parser.minute).to eq('15')
      end
    end

    context 'when input is 15, 32 and 48' do
      let(:cron) { '15,32,48 * * * *' }

      it 'returns 15 32 48' do
        expect(cron_parser.minute).to eq('15 32 48')
      end
    end

    context 'when input is */15' do
      let(:cron) { '*/15 * * * *' }

      it 'returns every minute in the hour it will run' do
        expect(cron_parser.minute).to eq('0 15 30 45')
      end
    end
  end
end
