describe CorrelationChecker do
  subject { described_class.new(first_dataset: first_dataset, second_dataset: second_dataset) }

  context 'with invalid params' do
    context 'with empty datasets' do
      let(:first_dataset) { [] }
      let(:second_dataset) { [] }

      it 'does not generate result' do
        expect(subject.perform).to eq false

        expect(subject.result).to eq nil
      end
    end

    context 'with different datasets' do
      let(:first_dataset) { [1, 2, 3] }
      let(:second_dataset) { [1, 2] }

      it 'does not generate result' do
        expect(subject.perform).to eq false

        expect(subject.result).to eq nil
      end
    end

    context 'with duplicates' do
      let(:first_dataset) { [1, 2, 2, 5, 6] }
      let(:second_dataset) { [1, 3, 2, 7, 5] }

      it 'generates result' do
        expect(subject.perform).to eq false

        expect(subject.result).to eq nil
      end
    end
  end

  context 'with valid params' do
    context 'with equal datasets' do
      let(:first_dataset) { [1, 2, 3, 4, 5] }
      let(:second_dataset) { [1, 2, 3, 4, 5] }

      it 'generates result' do
        expect(subject.perform).to eq true

        expect(subject.result).to eq 1
      end
    end

    context 'with different datasets' do
      let(:first_dataset) { [1, 2, 3, 4, 5] }
      let(:second_dataset) { [55, 74, 94, 108, 156] }

      it 'generates result' do
        expect(subject.perform).to eq true

        expect(subject.result).to eq 0.9713332474204632
      end
    end

    context 'with equal string datasets' do
      let(:first_dataset) { ['1', '2', '3', '4', '5'] }
      let(:second_dataset) { ['1', '2', '3', '4', '5'] }

      it 'generates result' do
        expect(subject.perform).to eq true

        expect(subject.result).to eq 1
      end
    end
  end
end
