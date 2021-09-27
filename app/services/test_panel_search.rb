class TestPanelSearch
  class RecordNotFound < StandardError; end
  attr_reader :test_id

  def initialize(test_id:, include:)
    @test_id = format_id(test_id)
    @required_test_info = required_test_info(include)
  end

  def execute
    raise RecordNotFound, "Test panel not found with given ID: #{test_id}" if test_panel.blank?

    parse_data
  end

  def parse_data
    puts 'its here'
    response = { data: test_panel_data }
    response[:included] = tests_data if @required_test_info
    response
  end

  def test_panel_data
    {
      type: 'test_panels',
      id: test_panel[:id],
      attributes: format_attributes(test_panel),
      relationships: { test: { data: test_panel_relationships } }
    }
  end

  def tests_data
    tests.map { |test| format_test_details(test) }
  end

  def format_attributes(test_panel)
    {
      'price': test_panel[:price],
      'sample_tube_types': tests_tube_types,
      'sample_volume_requirement': tests_volume_requirement
    }
  end

  def tests
    @tests ||= Test.details(test_panel[:tests])
  end

  def test_panel
    @test_panel ||= TestPanel.find_by_test_id(test_id)
  end

  private

  def required_test_info(include)
    include && include.downcase == 'test'
  end

  def format_id(id)
    id.gsub(/\s+/, '').upcase
  end

  def tests_tube_types
    tests.map { |test| test[:sample_tube_type] }
  end

  def tests_volume_requirement
    tests.sum { |test| test[:sample_volume_requirement].to_f }
  end

  def test_panel_relationships
    test_panel[:tests].map { |t_p| [id: t_p, type: 'test'] }
  end

  def format_test_details(test)
    {
      type: 'test',
      id: test[:id],
      attributes: {
        name: test[:name],
        sample_volume_requirement: test[:sample_volume_requirement],
        sample_tube_type: test[:sample_tube_type]
      }
    }
  end
end
