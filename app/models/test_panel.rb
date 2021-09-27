class TestPanel
  DATA = [
    {
      id: 'TP1',
      tests: ['CHO', 'VITD'],
      price: 1700
    },
    {
      id: 'TP2',
      tests: ['HBA1C', 'B12'],
      price: 2100
    },
    {
      id: 'TP3',
      tests: ['LFT', 'VITD', 'CHO'],
      price: 1800
    }
  ]

  class << self
    def find_by_test_id(test_id)
      DATA.detect { |test_p| test_p[:id] == test_id }
    end
  end
end
