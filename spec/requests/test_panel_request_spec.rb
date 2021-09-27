require 'rails_helper'

describe 'Requesting a test panel', type: :request do
  subject(:request) { get "/api/v1/test_panels?id=#{test_panel_id}&include=#{include}&api_key=#{secret}" }
  before do
    request
  end

  context 'when invalid api key passed' do
    let(:secret) { '10ae' }
    let(:test_panel_id) { 'TP2' }
    let(:include) { 'test' }

    it 'should respond with an HTTP 404 status' do
      expect(response).to have_http_status 404
    end

    context 'with response body' do
      it 'returns error message ' do
        expect(response.body).to eq('Unauthorized access.')
      end
    end
  end

  context 'with a valid test panel ID' do
    let(:secret) { '10ae820f-8c24-4e69-888b-03cbc36c89a6' }
    let(:test_panel_id) { 'TP1' }
    let(:include) { '' }

    it 'should respond with an HTTP 200 status' do
      expect(response).to have_http_status 200
    end

    it 'returns :json content type' do
      expect(response.headers['Content-Type']).to eq 'application/json; charset=utf-8'
    end

    context 'with response body' do
      it 'returns required test panel details' do
        expect(JSON.parse(response.body)).to eq({"data"=>{"type"=>"test_panels", "id"=>"TP1", "attributes"=>{"price"=>1700, "sample_tube_types"=>["yellow", "yellow"], "sample_volume_requirement"=>220.0}, "relationships"=>{"test"=>{"data"=>[[{"id"=>"CHO", "type"=>"test"}], [{"id"=>"VITD", "type"=>"test"}]]}}}})
      end
    end
  end

  context 'with a include value' do
    let(:secret) { '10ae820f-8c24-4e69-888b-03cbc36c89a6' }
    let(:test_panel_id) { 'TP1' }
    let(:include) { 'test' }

    it 'should respond with an HTTP 200 status' do
      expect(response).to have_http_status 200
    end

    it 'returns :json content type' do
      expect(response.headers['Content-Type']).to eq 'application/json; charset=utf-8'
    end

    context 'with response body' do
      it 'returns test panel with tests data' do
        expect(JSON.parse(response.body)['data']).to eq({"type"=>"test_panels", "id"=>"TP1", "attributes"=>{"price"=>1700, "sample_tube_types"=>["yellow", "yellow"], "sample_volume_requirement"=>220.0}, "relationships"=>{"test"=>{"data"=>[[{"id"=>"CHO", "type"=>"test"}], [{"id"=>"VITD", "type"=>"test"}]]}}})
        expect(JSON.parse(response.body)['included']).to eq([{"type"=>"test", "id"=>"CHO", "attributes"=>{"name"=>"Cholesterol", "sample_volume_requirement"=>100, "sample_tube_type"=>"yellow"}}, {"type"=>"test", "id"=>"VITD", "attributes"=>{"name"=>"Vitamin D", "sample_volume_requirement"=>120, "sample_tube_type"=>"yellow"}}])
      end
    end
  end

  context 'with a unknown test panel' do
    let(:secret) { '10ae820f-8c24-4e69-888b-03cbc36c89a6' }
    let(:test_panel_id) { '12' }
    let(:include) { 'test' }

    it 'should respond with an HTTP 404 status' do
      expect(response).to have_http_status 404
    end

    it 'returns :json content type' do
      expect(response.headers['Content-Type']).to eq 'application/json; charset=utf-8'
    end

    context 'with response body' do
      it 'returns error message' do
        expect(response.body).to eq('Test panel not found with given ID: 12')
      end
    end
  end
end
