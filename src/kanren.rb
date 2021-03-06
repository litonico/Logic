require 'stream'

class FreshVar; end

class Kanren
  def self.run_all &block
    # where block :: FreshVar -> Stream
    question = FreshVar.new
    answers = block.call(question) # a Stream of answers
    answers.all
  end

  def self.unify
  end

  def self.disj *streams
    streams.reduce(Stream::EMPTY) { |so_far, stream| so_far.append stream }
  end
end
