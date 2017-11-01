require 'spec_helper'
require 'command_runner'
require 'errors'

describe CommandRunner do
  let(:logger) { double(:logger, :error => {}, :info => {}) }
  let(:command_runner) { described_class.new(:logger => logger) }

  describe 'given a too many arguments' do
    it 'returns an error message' do
      command_runner.run(%w(arg_one arg_two arg_three))

      expect(logger).to have_received(:error).with("Error: Too many arguments!\n\nRun 'ruby app.rb --help' for usage information.\n")
    end
  end

  describe 'given no arguments' do
    it 'returns an error message' do
      command_runner.run([])

      expect(logger).to have_received(:error).with("Error: Not enough arguments!\n\nRun 'ruby app.rb --help' for usage information.\n")
    end
  end

  describe 'given only one argument' do
    it 'returns an error message' do
      command_runner.run(['arg_one'])

      expect(logger).to have_received(:error).with("Error: Not enough arguments!\n\nRun 'ruby app.rb --help' for usage information.\n")
    end
  end

  describe 'given the --help argument' do
    it 'returns usage information' do
      command_runner.run(['--help'])

      expect(logger).to have_received(:info).with("\n\nUsage:    ruby app.rb [CRON] [COMMAND]\n\nExample:  ruby app.rb \"0 0 * * *\" ./run_this.sh\n")
    end
  end

  describe 'given the cron parser throws an exception' do
    let(:cron_parser) { double(:cron_parser) }
    let(:command_runner) { described_class.new(:logger => logger, :cron_parser => cron_parser) }

    before do
      allow(cron_parser).to receive(:parse).and_raise(InvalidFormatError, 'Something wrong')
    end

    it 'returns a friendlier error message' do
      command_runner.run(['invalid cron', 'arg_two'])

      expect(logger).to have_received(:error).with("Error: Something wrong\n\nRun 'ruby app.rb --help' for usage information.\n")
    end
  end

  describe 'given a valid cron' do
    let(:cron_schedule) { '0 0 * * *' }
    let(:cron_command) { '/usr/bin/find' }

    before do
      command_runner.run([cron_schedule, cron_command])
    end

    context 'which should run every day at midnight' do
      let(:cron_schedule) { '0 0 * * *' }
      let(:expected_message) do
        "\nminute        0
hour          0
day of month  1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
month         1 2 3 4 5 6 7 8 9 10 11 12
day of week   1 2 3 4 5 6 7
command       /usr/bin/find\n"
      end

      it 'outputs a correctly formatted breakdown of when and what will be scheduled to run' do
        expect(logger).to have_received(:info).with(expected_message)
      end
    end

    context 'which runs a different command' do
      let(:cron_command) { './my-script.sh' }
      let(:expected_command) { 'command       ./my-script.sh' }

      it 'outputs a breakdown of when the cron will be scheduled to run' do
        expect(logger).to have_received(:info).with(/#{expected_command}/)
      end
    end
  end
end
