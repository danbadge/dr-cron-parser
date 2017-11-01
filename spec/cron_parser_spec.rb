require 'cron_parser'
require 'cron_summary'

describe CronParser do
  let(:parse_cron) { described_class.new.parse(cron) }

  describe 'given a cron' do
    context 'which is valid' do
      let(:cron) { '* */22 0 5 1,2' }

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
        let(:cron) { '60 * * * *' }

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

      context 'because a number in the collection is out of bounds' do
        let(:cron) { '12,-1 * * * *' }

        it 'throws an exception' do
          expect { parse_cron }.to raise_error(CronParser::InvalidFormatError, 'Minute is in an invalid format')
        end
      end

      context 'because a running the command every 25 hours is out of bounds' do
        let(:cron) { '*/61 * * * *' }

        it 'throws an exception' do
          expect { parse_cron }.to raise_error(CronParser::InvalidFormatError, 'Minute is in an invalid format')
        end
      end
    end

    context 'when hour is invalid' do
      context 'because it is a string' do
        let(:cron) { '* what * * *' }

        it 'throws an exception' do
          expect { parse_cron }.to raise_error(CronParser::InvalidFormatError, 'Hour is in an invalid format')
        end
      end

      context 'because it contains a string' do
        let(:cron) { '* 10,wat * * *' }

        it 'throws an exception' do
          expect { parse_cron }.to raise_error(CronParser::InvalidFormatError, 'Hour is in an invalid format')
        end
      end

      context 'because it is greater than 23' do
        let(:cron) { '* 24 * * *' }

        it 'throws an exception' do
          expect { parse_cron }.to raise_error(CronParser::InvalidFormatError, 'Hour is in an invalid format')
        end
      end

      context 'because it less than 0' do
        let(:cron) { '* -1 * * *' }

        it 'throws an exception' do
          expect { parse_cron }.to raise_error(CronParser::InvalidFormatError, 'Hour is in an invalid format')
        end
      end

      context 'because a number in the collection is out of bounds' do
        let(:cron) { '* 12,-1 * * *' }

        it 'throws an exception' do
          expect { parse_cron }.to raise_error(CronParser::InvalidFormatError, 'Hour is in an invalid format')
        end
      end

      context 'because a running the command every 25 hours is out of bounds' do
        let(:cron) { '* */25 * * *' }

        it 'throws an exception' do
          expect { parse_cron }.to raise_error(CronParser::InvalidFormatError, 'Hour is in an invalid format')
        end
      end
    end
  end
end
