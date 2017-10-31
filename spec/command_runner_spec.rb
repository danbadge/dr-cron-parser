require 'spec_helper'
require 'command_runner'

describe CommandRunner do
  describe 'given a valid cron' do
    let(:cron_schedule) { '0 0 * * *' }
    let(:cron_command) { '/usr/bin/find' }

    context 'which should run every day at midnight' do
      let(:cron_schedule) { '0 0 * * *' }
      let(:expected_message) do
        "\nminute        0
hour          0
day of month  1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
month         1 2 3 4 5 6 7 8 9 10 11 12
day of week   1 2 3 4 5 6 7
command       /usr/bin/find\n\n"
      end

      it 'outputs a correctly formatted breakdown of when and what will be scheduled to run' do
        expect { CommandRunner.run([cron_schedule, cron_command]) }.to output(expected_message).to_stdout
      end
    end

    context 'which runs a different command' do
      let(:cron_command) { './my-script.sh' }
      let(:expected_command) { 'command       ./my-script.sh' }

      it 'outputs a breakdown of when the cron will be scheduled to run' do
        expect { CommandRunner.run([cron_schedule, cron_command]) }.to output(/#{expected_command}/).to_stdout
      end
    end
  end
end
