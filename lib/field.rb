require_relative 'errors'

class Field
  def initialize(value:, lower_bound:, upper_bound:, field_name:)
    @value = value
    @lower_bound = lower_bound
    @upper_bound = upper_bound
    @field_name = field_name
  end

  def parse!
    rule = parsing_rules.find { |r| r.fetch(:matches?).call(value) }
    raise InvalidFormatError, "#{field_name} is in an invalid format" unless rule[:valid?].call(value)
  end

  def summarise
    rule = parsing_rules.select { |r| r.fetch(:matches?).call(value) }
    rule.first[:result].call(value)
  end

  private

  attr_reader :value, :lower_bound, :upper_bound, :field_name

  def parsing_rules
    [
      {
        :name => 'every_x',
        :matches? => proc { |value| value =~ %r{\*\/(\d+)} },
        :valid? => proc do |value|
          value_every_x = value[/(\d+)/]
          valid_single_value?(value_every_x)
        end,
        :result => proc do |value|
          value_every_x = value[/(\d+)/]
          (lower_bound..upper_bound).select { |v| v.to_i.modulo(value_every_x.to_i).zero? }.join(' ')
        end
      },
      {
        :name => 'wildcard',
        :matches? => proc { |value| value == '*' },
        :valid? => proc { |_value| true },
        :result => proc { |_value| (lower_bound..upper_bound).to_a.join(' ') }
      },
      {
        :name => 'range',
        :matches? => proc { |value| value =~ /(\d+)-(\d+)/ },
        :valid? => proc { |value| value.split('-').all? { |v| valid_single_value?(v) } },
        :result => proc do |value|
          values = value.split('-').map(&:to_i)
          (values.first..values.last).to_a.join(' ')
        end
      },
      {
        :name => 'collection',
        :matches? => proc { |_value| true },
        :valid? => proc { |value| value.split(',').all? { |v| valid_single_value?(v) } },
        :result => proc { |value| value.split(',').map(&:to_i).join(' ') }
      }
    ]
  end

  def valid_single_value?(value)
    number = Integer(value)
    number <= upper_bound && number >= lower_bound
  rescue => _error
    false
  end
end
