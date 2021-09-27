require 'rails_helper'

describe TestPanel, type: :model do
  it 'should store the data in a DATA constant' do
    expect(TestPanel::DATA.length > 0).to eq true
  end

  describe '#find_by_test_id' do
    subject(:request) { TestPanel.find_by_test_id(test_id) }

    context 'when valid test_id passed' do
      let(:test_id) { 'TP1' }
      it 'should return test panel details' do
        expect(request).to eq({ id: 'TP1',
                                tests: ['CHO', 'VITD'],
                                price: 1700 })
      end
    end

    context 'when invalid test_id passed' do
      let(:test_id) { '67j' }
      it 'should return nil' do
        expect(request).to eq(nil)
      end
    end
  end
end
