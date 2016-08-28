class Analyser
  def analyse(data)
    if validate_dataset(data)
      data.sort!
      { 'max' => data.max,
        'min' => data.min,
        'mean' => mean(data),
        'median' => median(data),
        'lower_quartile' => lower_quartile(data),
        'upper_quartile' => upper_quartile(data),
        'outliers' => outliers(data) }
    end
  end

  def correlation(first, second)
    if validate_dataset(first) && validate_dataset(second) && first.size == second.size
      first.map { |element| element - mean(first) }
           .zip(second.map { |element| element - mean(second) })
           .map! { |element| element.reduce(:*) } .reduce(:+) /
        Math.sqrt(first.map { |element| (element - mean(first))**2 } .reduce(:+) *
                  second.map { |element| (element - mean(second))**2 } .reduce(:+))
    end
  end

  private

  def validate_dataset(dataset)
    dataset.respond_to?(:each) && dataset.all? { |e| e.is_a? Numeric }
  end

  def mean(data)
    data.reduce(:+) / data.size.to_f
  end

  def median(data)
    mean([data[data.size.to_f / 2.0], data[-data.size.to_f / 2.0 - 1]])
  end

  def lower_quartile(data)
    median(data[0, data.size / 2])
  end

  def upper_quartile(data)
    median(data[(data.size.to_f / 2).ceil, data.size])
  end

  def outliers(data)
    lq = lower_quartile(data)
    uq = upper_quartile(data)
    data.select do |element|
      element < lq - 1.5 * (uq - lq) || element > uq + 1.5 * (uq - lq)
    end
  end
end
