
# In order to avoid database flood we sum up some events (disk revolution, led flash or voltage pusle) into a buffer
# options: should be :count_max and/or :duration_max will reset the buffer and trigger the exeecution block.
# block : allow to trigger some code after each event.

class Buffer
  attr_reader :started_at, :content
  attr_writer :flush_block

  def initialize options = {}, &block
    raise ":seed object should be provided." unless options[:seed]
    @options = options
    flush
    @flush_block = block if block_given?
  end

  def age
    Time.now - @started_at
  end

  def add val
    @content = val
    run_flush
    val
  end

  def flush
    @started_at = Time.now
    @content = @options[:seed].dup
    true
  end

  def flush?
    return true if @options[:size] && (@content.size >= @options[:size])
    return true if @options[:max_age] && (age >= @options[:max_age])
    return false
  end

  def run_flush
    if flush?
      instance_eval(&@flush_block) if @flush_block
      flush
    end
  end

end

class AdditivBuffer < Buffer
  def initialize options = {}, &block
    options[:seed] = 0
    super
  end

  def add val
    @content += val
    run_flush
    val
  end

  def flush?
    return true if @options[:size] && (@content >= @options[:size])
    return true if @options[:max_age] && (age >= @options[:max_age])
    return false
  end
end

class CounterBuffer < AdditivBuffer
  def add
    super(1)
  end
  alias :top :add
end

class CollectionBuffer < Buffer
  def initialize options = {}, &block
    options[:seed] = Array.new
    super
  end

  def add val
    @content << val
    run_flush
    val
  end

  def flush?
    return true if @options[:size] && (@content.size >= @options[:size])
    return true if @options[:max_age] && (age >= @options[:max_age])
    return false
  end
end

class AverageBuffer < CollectionBuffer
  def average
    @content.reduce(:+) / @content.size rescue 0
  end
end

class FrequencyBuffer < AverageBuffer
  def top
    add Time.now - @last_top if @last_top
    @last_top = Time.now
  end

  def frequency(instant = false)
    1 / (instant ? @content.last : average) rescue 0
  end

  def rpm(instant = false)
    60 * frequency(instant)
  end

  def rph(instant = false)
    60 * rpm(instant)
  end

  def duration
    @content.reduce(:+)
  end
end

class StringBuffer < CollectionBuffer
  def initialize options = {}, &block
    options[:seed] = String.new
    super
  end
end
