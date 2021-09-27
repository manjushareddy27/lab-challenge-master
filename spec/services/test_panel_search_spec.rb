require 'rails_helper'

describe TestPanelSearch do
  describe '#execute' do
    subject(:request) { TestPanelSearch.new(test_id: test_id, include: include).execute }

    context 'when valid test_id passed' do
      let(:test_id) { 'Tp1' }
      let(:include) { '' }
      it 'returns testpanel response' do
        expect(request).to eq({:data=>{:type=>"test_panels", :id=>"TP1", :attributes=>{:price=>1700, :sample_tube_types=>[:yellow, :yellow], :sample_volume_requirement=>220.0}, :relationships=>{:test=>{:data=>[[{:id=>"CHO", :type=>"test"}], [{:id=>"VITD", :type=>"test"}]]}}}})
      end
    end

    context 'when valid test_id and include passed' do
      let(:test_id) { 'Tp1' }
      let(:include) { 'test' }
      it 'returns testpanel included test details' do
        expect(request).to eq({:data=>{:type=>"test_panels", :id=>"TP1", :attributes=>{:price=>1700, :sample_tube_types=>[:yellow, :yellow], :sample_volume_requirement=>220.0}, :relationships=>{:test=>{:data=>[[{:id=>"CHO", :type=>"test"}], [{:id=>"VITD", :type=>"test"}]]}}}, :included=>[{:type=>"test", :id=>"CHO", :attributes=>{:name=>"Cholesterol", :sample_volume_requirement=>100, :sample_tube_type=>:yellow}}, {:type=>"test", :id=>"VITD", :attributes=>{:name=>"Vitamin D", :sample_volume_requirement=>120, :sample_tube_type=>:yellow}}]})
      end
    end

    context 'when invalid test_id passed' do
      let(:test_id) { '2' }
      let(:include) { 'test' }
      it 'returns an error' do
        expect{ request }.to raise_error(TestPanelSearch::RecordNotFound)
      end
    end
  end
end
