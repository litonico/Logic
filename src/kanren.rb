require 'stream'

class FreshVar; end

class Kanren
  def self.run_all &block
    question = FreshVar.new
    block.call(question).nil?
  end

  def self.unify
  end
end
