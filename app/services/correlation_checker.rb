class CorrelationChecker
  attr_reader :result

  def initialize(first_dataset:, second_dataset:)
      @first_dataset = first_dataset
      @second_dataset = second_dataset
  end

  def perform
    return false unless (numeric_datasets? || (string_datasets? && parse_datasets)) &&
      valid_datasets?

    correlation
  end

private

  def numeric_datasets?
    def numeric?(dataset)
      dataset.all? { |e| e.is_a? Numeric }
    end

    numeric?(@first_dataset) && numeric?(@second_dataset)
  end

  def string_datasets?
    def string?(dataset)
      dataset.all? { |e| e.is_a? String }
    end

    string?(@first_dataset) && string?(@second_dataset)
  end

  def parse_datasets
    def parse_dataset(dataset)
      return dataset.map! &:to_f unless dataset.map! { |e| e[/\d+/] }.any? { |e| e.nil? }

      false
    end

    parse_dataset(@first_dataset) && parse_dataset(@second_dataset)
  end

  def valid_datasets?
    @first_dataset.uniq!
    @second_dataset.uniq!

    @first_dataset.size > 1 && @second_dataset.size > 1 &&
      @first_dataset.size == @second_dataset.size
  end

  def correlation
      @result = numerator / denominator

      true
  end

  def numerator
    @first_dataset.map { |element| element - mean(@first_dataset) }
      .zip(@second_dataset.map { |element| element - mean(@second_dataset) })
      .map! { |element| element.reduce(:*) } .reduce (:+)
  end

  def denominator
    Math.sqrt(@first_dataset.map { |element| (element - mean(@first_dataset))**2 } .reduce(:+) *
      @second_dataset.map { |element| (element - mean(@second_dataset))**2 } .reduce(:+))
  end

  def mean(numbers)
    numbers.reduce(:+) / numbers.size.to_f
  end
end
