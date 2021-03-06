require 'spec_helper'
require 'field'
require 'errors'

describe Field do
  let(:field) do
    described_class.new(
      :value => value,
      :lower_bound => 0,
      :upper_bound => 21,
      :field_name => 'field'
    )
  end

  context 'when input is a single value' do
    let(:value) { '15' }

    it 'returns that single value' do
      expect(field.summarise).to eq('15')
    end
  end

  context 'when input is a collection of values' do
    let(:value) { '2,10,16' }

    it 'returns the collection' do
      expect(field.summarise).to eq('2 10 16')
    end
  end

  context 'when input is every 3' do
    let(:value) { '*/3' }

    it 'returns the number when it will run' do
      expect(field.summarise).to eq('0 3 6 9 12 15 18 21')
    end
  end

  context 'when input is every 11' do
    let(:value) { '*/11' }

    it 'returns the number when it will run' do
      expect(field.summarise).to eq('0 11')
    end
  end

  context 'when input is a wildcard' do
    let(:value) { '*' }

    it 'returns every number in the bounds' do
      expect(field.summarise).to eq('0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21')
    end
  end

  context 'when input is a range' do
    let(:value) { '1-8' }

    it 'returns every number in the range' do
      expect(field.summarise).to eq('1 2 3 4 5 6 7 8')
    end
  end

  context 'when value is invalid' do
    context 'because it contains a string' do
      let(:value) { '10,wat' }

      it 'throws an exception' do
        expect { field.parse! }.to raise_error(InvalidFormatError, 'field is in an invalid format')
      end
    end

    context 'because it is greater than 59' do
      let(:value) { '22' }

      it 'throws an exception' do
        expect { field.parse! }.to raise_error(InvalidFormatError, 'field is in an invalid format')
      end
    end

    context 'because it less than 0' do
      let(:value) { '-1' }

      it 'throws an exception' do
        expect { field.parse! }.to raise_error(InvalidFormatError, 'field is in an invalid format')
      end
    end

    context 'because a number in the collection is out of bounds' do
      let(:value) { '12,-1' }

      it 'throws an exception' do
        expect { field.parse! }.to raise_error(InvalidFormatError, 'field is in an invalid format')
      end
    end

    context 'because running a command every 22 mins is out of bounds' do
      let(:value) { '*/22' }

      it 'throws an exception' do
        expect { field.parse! }.to raise_error(InvalidFormatError, 'field is in an invalid format')
      end
    end

    context 'because a number in a range is out of bounds' do
      let(:value) { '1-26' }

      it 'throws an exception' do
        expect { field.parse! }.to raise_error(InvalidFormatError, 'field is in an invalid format')
      end
    end
  end
end
