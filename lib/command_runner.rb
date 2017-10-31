require 'logger'
require_relative 'cron_parser'

class CommandRunner
  def initialize(logger: Logger.new(STDOUT))
    @logger = logger
  end

  def run(args)
    return if help_requested?(args)
    return unless valid?(args)

    parser = CronParser.new(args[0])

    logger.info("\nminute        #{parser.minute}
hour          0
day of month  1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
month         1 2 3 4 5 6 7 8 9 10 11 12
day of week   1 2 3 4 5 6 7
command       #{args[1]}\n")
  end

  private

  attr_reader :logger

  def help_requested?(args)
    if args.first == '--help'
      logger.info("\n\nUsage:    ruby app.rb [CRON] [COMMAND]\n\nExample:  ruby app.rb \"0 0 * * *\" ./run_this.sh\n")
      return true
    end

    false
  end

  def valid?(args)
    if args.length > 2
      output_error_message('Too many arguments!')
      return false
    elsif args.length < 2
      output_error_message('Not enough arguments!')
      return false
    end

    true
  end

  def output_error_message(detailed_message)
    logger.error("Error: #{detailed_message}\n\nRun 'ruby app.rb --help' for usage information.\n")
  end
end
