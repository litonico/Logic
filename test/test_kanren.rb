require 'minitest/autorun'
require 'kanren'

class TestKanren < Minitest::Test
  def test_running_kanren_expression
    assert_equal Kanren.run_all(:q) {}, []
    assert_equal Kanren.run_all(:q) {
    }, [FreshVar.new]
  end
end
