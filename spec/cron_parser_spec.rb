require 'cron_parser'

describe CronParser do
  let(:parse_cron) { described_class.new.parse(cron) }

  describe 'given a cron' do
    context 'which is valid' do
      let(:cron) { '* 15/40 0 1-5 1,2' }

      it 'returns a cron summary' do
        expect(parse_cron).to be_an_instance_of(CronSummary)
      end
    end

    context 'when minute is invalid' do
      context 'because it is a string' do
        let(:cron) { 'what-is-this * * * *' }

        it 'throws an exception' do
          expect { parse_cron }.to raise_error(CronParser::InvalidFormatError, 'Minute is in an invalid format')
        end
      end

      context 'because it contains a string' do
        let(:cron) { '10,wat * * * *' }

        it 'throws an exception' do
          expect { parse_cron }.to raise_error(CronParser::InvalidFormatError, 'Minute is in an invalid format')
        end
      end

      context 'because it is greater than 59' do
        let(:cron) { '555 * * * *' }

        it 'throws an exception' do
          expect { parse_cron }.to raise_error(CronParser::InvalidFormatError, 'Minute is in an invalid format')
        end
      end

      context 'because it less than 0' do
        let(:cron) { '-1 * * * *' }

        it 'throws an exception' do
          expect { parse_cron }.to raise_error(CronParser::InvalidFormatError, 'Minute is in an invalid format')
        end
      end
    end
  end
end
