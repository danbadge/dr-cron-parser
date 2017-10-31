require 'spec_helper'

describe 'something' do
  context 'given there is something which should return true' do
    it 'returns false' do
      expect(true).to eq(false)
    end
  end
end
