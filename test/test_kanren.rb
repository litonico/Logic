require 'minitest/autorun'
require 'minitest/mock'
require 'kanren'


# KanrenVar.new(:q).is KanrenVar(:x) syntax?

class TestKanren < Minitest::Test
  def test_running_kanren_expression
    Kanren.stub(:unify, true) do
      assert_equal [true], Kanren.run_all{|q| Kanren.unify(q, true) }
    end

    assert_equal [FreshVar.new], Kanren.run_all {|q| }
  end
end
