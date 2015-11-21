require 'minitest/autorun'
require 'minitest/mock'
require 'kanren'


# KanrenVar.new(:q).is KanrenVar(:x) syntax?

class TestKanren < Minitest::Test
  def test_running_empty_kanren_expression
    assert_equal [], Kanren.run_all {|q| Stream::EMPTY }
  end

  def test_kanren_returns_a_result
    Kanren.stub(:unify, Stream.new(true){ Stream::EMPTY }) do
      assert_equal [true], Kanren.run_all{|q| Kanren.unify(q, true) }
    end
  end

  def test_kanren_returns_many_results
    results = Stream.new(1) { Stream.new(2) { Stream::EMPTY } }
    Kanren.stub(:disj, results) do
      assert_equal [1, 2], Kanren.run_all{ |q| Kanren.disj() }
    end
  end

  def test_unification
  end

  def test_disjunction_aka_or
    a = Stream.new(1) { Stream.new(2) { Stream::EMPTY } }
    b = Stream.new(5) { Stream.new(7) { Stream::EMPTY } }

    results = Stream.new(1) {
      Stream.new(2) {
        Stream.new(5) {
          Stream.new(7) {
            Stream::EMPTY
          }
        }
      }
    }

    assert_equal results.all, Kanren.disj(a, b).all
    assert_equal results.all.sort, Kanren.disj(b, a).all.sort
  end

  def test_conjunction_aka_and
    skip
  end

end
