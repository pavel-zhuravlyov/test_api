class CorrelationChecker
  attr_reader :result

  def initialize(first_dataset:, second_dataset:)
      @first_dataset = first_dataset
      @second_dataset = second_dataset
  end

  def perform
    return false unless (datasets_are_numeric || parse_datasets) &&
      datasets_are_not_empty_and_of_equal_size

    correlation
  end

private

  def datasets_are_numeric
    def is_numeric?(dataset)
      return dataset.all? {|e| e.is_a? Numeric}
    end

    is_numeric?(@first_dataset) && is_numeric?(@second_dataset)
  end

  def datasets_are_not_empty_and_of_equal_size
    @first_dataset.any? && @second_dataset.any? &&
      @first_dataset.size == @second_dataset.size
  end

  def parse_datasets
    def parse_dataset(dataset)
      unless dataset.map! {|e| e[/\d+/]}.any? {|e| e.nil?} then
        dataset.map! &:to_f
      else
        false
      end
    end

    parse_dataset(@first_dataset) && parse_dataset(@second_dataset)
  end

  def correlation
      @result = numerator / denominator

      true
  end

  def numerator
    @first_dataset.map { |element| element - mean(@first_dataset) }
      .zip(@second_dataset.map { |element| element - mean(@second_dataset) })
      .map! { |element| element.reduce(:*) } .reduce(:+)
  end

  def denominator
    Math.sqrt(@first_dataset.map { |element| (element - mean(@first_dataset))**2 } .reduce(:+) *
      @second_dataset.map { |element| (element - mean(@second_dataset))**2 } .reduce(:+))
  end

  def mean(numbers)
    numbers.reduce(:+) / numbers.size.to_f
  end
end
