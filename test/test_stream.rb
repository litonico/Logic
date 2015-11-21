require 'minitest/autorun'
require 'minitest/focus'
require 'stream'

FIN = Stream::EMPTY

class TestStream < Minitest::Test
  def setup
    @one_two = Stream.new(1){ Stream.new(2){ FIN } }

    def naturals n
      Stream.new(n) { naturals n+1 }
    end
    @nats = naturals 1
  end

  def test_stream_get_head
    assert_equal 1, @one_two.head
  end

  def test_stream_get_rest
    assert_equal @one_two.rest.head, 2
    assert_equal 5, @nats.rest.rest.rest.rest.head
  end

  def test_stream_take_n
    assert_equal (1..10).to_a, naturals(1).take(10)
    assert_equal [1,2], @one_two.take(10)
  end

  def test_stream_append
    appended = @one_two.append(Stream.new(3){ FIN })

    expected = Stream.new(1){ Stream.new(2){ Stream.new(3){ FIN } } }

    assert_equal expected.take(3), appended.take(3)
  end

  def test_stream_interleave
    a_b = Stream.new("a") { Stream.new ("b") { FIN } }

    expected = Stream.new(1) {
      Stream.new("a") {
        Stream.new(2) {
          Stream.new ("b") {
            FIN
          }
        }
      }
    }

    assert_equal expected.take(4), @one_two.interleave(a_b).take(4)
  end

  def test_stream_map
    two_three = @one_two.map {|x| x + 1 }
    expected = Stream.new(2){ Stream.new(3){ FIN } }
    assert_equal expected.take(2), two_three.take(2)

    to_append = Stream.new(3) { FIN }
    expected = expected.append(to_append)
    assert_equal expected.take(3), two_three.append(to_append).take(3)
  end

  def test_stream_all
    assert_equal [1,2], @one_two.all
  end
end
