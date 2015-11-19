class Stream
  attr_reader :head
  def initialize head, &calc
    @head = head
    @calc = calc
  end

  EMPTY_STREAM = Stream.new(nil){ nil }

  def rest
    @calc.call
  end

  def empty?
    self == Stream::EMPTY_STREAM
  end

  def take n
    if self.empty? || n == 0
      []
    else
       [self.head] + self.rest.take(n-1)
    end
  end

  def append other
    if self.empty?
      other
    else
      Stream.new(self.head) do
        if self.rest.nil?
          other
        else
          self.rest.append other
        end
      end
    end
  end

  def interleave other
    Stream.new(self.head) do
      if self.empty?
        other
      else
        other.interleave self.rest.interleave(other)
      end
    end
  end

  def map &block
    Stream.new(block.call(self.head)) do
      if self.rest.empty?
        EMPTY_STREAM
      else
        self.rest.map(&block)
      end
    end
  end
end
