class Stream
  attr_reader :head
  def initialize head, &calc
    @head = head
    @calc = calc
  end

  def rest
    @calc.call
  end

  def empty?
    head.nil?
  end

  def take n
    s = self
    res = []
    n.times do
      res << s.head
      s = s.rest
      unless s.is_a? Stream # If the stream ends before n elems, stop
        break
      end
    end
    res
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
      if self.rest.nil?
        other
      else
        other.interleave self.rest.interleave(other)
      end
    end
  end

  def map &block
    Stream.new(block.call(self.head)) do
      if self.rest.nil?
        nil
      else
        self.rest.map(&block)
      end
    end
  end
end
