describe Analyser do
  subject { described_class.new(dataset: dataset) }

  context 'with invalid params' do
    context 'with non numeric dataset' do
      let(:dataset) { ['a', 'b', 'c'] }

      it 'does not generate result' do
        expect(subject.perform).to eq false
        expect(subject.result).to eq nil
      end
    end

    context 'with empty dataset' do
      let(:dataset) { [] }

      it 'does not generate result' do
        expect(subject.perform).to eq false
        expect(subject.result).to eq nil
      end
    end
  end

  context 'with valid params' do
    let(:dataset) { [5, 6, 7, 13, 43, 45, 46, 55, 56, 60, 61, 62, 65, 66, 66, 67, 90, 100, 104, 132] }
    let(:expected_response) {
      { max: 132,
        min: 5,
        mean:	57.45,
        median:	60.5,
        lower_quartile:	44,
        upper_quartile:	66.5,
        outliers:	[5, 6, 7, 104, 132] }
    }

    it 'generates result' do
      expect(subject.perform).to eq true
      expect(subject.result).to eq expected_response
    end
  end
end
