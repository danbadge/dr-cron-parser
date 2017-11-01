require 'cron_parser'
require 'cron_summary'
require 'errors'

describe CronParser do
  let(:parse_cron) { described_class.new.parse(cron) }

  describe 'given a cron' do
    context 'which is valid' do
      let(:cron) { '* */22 0 5 1,2' }

      it 'returns a cron summary' do
        expect(parse_cron).to be_an_instance_of(CronSummary)
      end
    end

    context 'which is contains a string' do
      let(:cron) { 'what-is-this * * * *' }

      it 'throws an exception' do
        expect { parse_cron }.to raise_error(InvalidFormatError, 'Minute is in an invalid format')
      end
    end
  end
end
