class CommandRunner
  def initialize(logger: Logger.new(STDOUT))
    @logger = logger
  end

  def run(args)
    return unless valid?(args)

    logger.info("\nminute        0
hour          0
day of month  1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
month         1 2 3 4 5 6 7 8 9 10 11 12
day of week   1 2 3 4 5 6 7
command       #{args[1]}\n\n")
  end

  private

  attr_reader :logger

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
    logger.error("Error: #{detailed_message}\nRun ruby app.rb --help for usage information.")
  end
end
