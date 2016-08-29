class CorrelationChecker
  attr_reader :result

  def initialize(first_dataset:, second_dataset:)
      @first_dataset = first_dataset
      @second_dataset = second_dataset
  end

  def perform
    return false unless validate_dataset(@first_dataset) &&
      validate_dataset(@second_dataset) &&
      @first_dataset.size == @second_dataset.size

      correlation
  end

private

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

  def validate_dataset(dataset)
    dataset.respond_to?(:each) && dataset.size > 0 && dataset.all? { |e| e.is_a? Numeric }
  end

  def mean(numbers)
    numbers.reduce(:+) / numbers.size.to_f
  end
end
