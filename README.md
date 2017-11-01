# dr-cron-parser

How to Install
-----
Clone this repository:
````
  $ git clone https://github.com/danbadge/dr-cron-parser
````
Install all the relevant gems:
````
  $ bundle install
````

How to Run
-----
From the command line in the directory for this repository:
````
  $ ruby app.rb --help
  $ ruby app.rb "0 0 * * *" something_to_run.sh
````

How to Test
-----
Run all the tests by doing:
````
  $ bundle exec rspec
````

Notes / Improvements
-----
Overall I'm fairly happy with the outcome but there's always room for some improvements.

* Firstly, `Field` holds all the complexity. This seems like necessary complexity but I'm not happy that it's buried under a few layers and that it's called "field". The name and the layers doesn't make it obvious enough for me that there's more going here.
* `CronParser` and `CronSummary` don't do too much and add some misdirection. They just delegate and provides a slightly nicer interface.
* This isn't very thought through but I think I've got two similar patterns for the array of rules and the classes in `fields.rb`. I'm sure these could conform somehow so there's at least some consistency.
* On a similar note, I'd like to get rid of `fields.rb` all together there's no need to use a class object and singleton method. 
