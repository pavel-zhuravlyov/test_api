class Analyser
  attr_reader :result

  def initialize(dataset:)
    @dataset = dataset
  end

  def perform
    return false unless (dataset_is_numeric || parse_dataset) && @dataset.any?

    analyse
  end

private

  def dataset_is_numeric
    @dataset.all? { |e| e.is_a? Numeric }
  end

  def parse_dataset
    unless @dataset.map! { |e| e[/\d+/] }.any? { |e| e.nil? } then
      @dataset.map! &:to_f
    else
      false
    end
  end

  def analyse
    @dataset.sort!

    @result = {
      max: @dataset.max,
      min: @dataset.min,
      mean: mean(@dataset),
      median: median(@dataset),
      lower_quartile: lower_quartile(@dataset),
      upper_quartile: upper_quartile(@dataset),
      outliers: outliers(@dataset)
    }

    true
  end

  def mean(numbers)
    numbers.reduce(:+) / numbers.size.to_f
  end

  def median(numbers)
    mean([numbers[numbers.size.to_f / 2.0], numbers[-numbers.size.to_f / 2.0 - 1]])
  end

  def lower_quartile(numbers)
    median(numbers[0, numbers.size / 2])
  end

  def upper_quartile(numbers)
    median(numbers[(numbers.size.to_f / 2).ceil, numbers.size])
  end

  def outliers(numbers)
    lq = lower_quartile(numbers)
    uq = upper_quartile(numbers)

    numbers.select do |element|
      element < lq - 1.5 * (uq - lq) || element > uq + 1.5 * (uq - lq)
    end
  end
end
