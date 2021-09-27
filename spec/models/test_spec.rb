require 'rails_helper'

describe Test, type: :model do
  it 'should store the data in a DATA constant' do
    expect(Test::DATA.length > 0).to eq true
  end

  describe '#details' do
    subject(:request) { Test.details(test_ids) }

    context 'when valid test_id passed' do
      let(:test_ids) { ['B12'] }
      it 'should return test details' do
        expect(request).to be_an(Array)
        expect(request).to eq([{ id: 'B12',
                                 name: 'Vitamin B12',
                                 sample_volume_requirement: 180,
                                 sample_tube_type: :yellow }])
      end
    end

    context 'when invalid test_id passed' do
      let(:test_ids) { [''] }
      it 'should return empty array' do
        expect(request).to eq([])
      end
    end
  end
end
