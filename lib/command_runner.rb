class CommandRunner
  def self.run(args)
    new.run(args)
  end

  def run(_args)
    printf "\nminute        0
hour          0
day of month  1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
month         1 2 3 4 5 6 7 8 9 10 11 12
day of week   1 2 3 4 5 6 7
command       /usr/bin/find\n\n"
  end
end
