require 'logger'
require_relative 'cron_parser'
require_relative 'errors'

class CommandRunner
  def initialize(logger: Logger.new(STDOUT), cron_parser: CronParser.new)
    @logger = logger
    @cron_parser = cron_parser
  end

  def run(args)
    return if help_requested?(args)
    return unless valid?(args)

    cron_summary = cron_parser.parse(args[0])

    logger.info("\nminute        #{cron_summary.minute}
hour          #{cron_summary.hour}
day of month  #{cron_summary.day}
month         #{cron_summary.month}
day of week   1 2 3 4 5 6 7
command       #{args[1]}\n")

  rescue InvalidFormatError => error
    logger.error(output_error_message(error.message))
  end

  private

  attr_reader :logger, :cron_parser

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
