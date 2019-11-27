# frozen_string_literal: true

module Enumerable
  # rubocop:disable Style/RedundantSelf, Style/For
  # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

  def my_each
    if block_given?
      for i in 0...self.length
        yield(self [i])
      end
    else
      to_enum(:my_each)
    end
  end

  def my_each_with_index
    if block_given?
      for i in 0...self.length
        yield(self[i], i)
      end
    else
      to_enum(:my_each_with_index)
    end
  end

  def my_select
    if block_given?
      return_arr = []
      self.my_each { |x| return_arr << x if yield(x) }
      return_arr.nil? ? (return false) : (return return_arr)
    else
      to_enum(:my_select)
    end
  end

  def my_all?(pattern = nil)
    if block_given?
      self.my_select { |x| yield(x) }.length == self.length ? (return true) : (return false)
    elsif !pattern.nil?
      if pattern.is_a?(Regexp)
        self.my_each { |x| return false unless pattern.match(x.to_s) }
      elsif pattern.is_a?(Class)
        self.my_each { |x| return false unless x.is_a?(pattern) }
      else
        self.my_each { |x| return false unless x == pattern }
      end
    else
      self.my_each { |x| return false unless x }
    end
    true
  end

  def my_any?(pattern = nil)
    if block_given?
      self.my_select { |x| yield(x) }.length.positive? ? (return true) : (return false)
    elsif !pattern.nil?
      if pattern.is_a?(Regexp)
        self.my_each { |x| return true if pattern.match(x.to_s) }
      elsif pattern.is_a?(Class)
        self.my_each { |x| return true if x.is_a?(pattern) }
      else
        self.my_each { |x| return true if x == pattern }
      end
    else
      self.my_each { |x| return true if x }
    end
    false
  end

  def my_none?(pattern = nil)
    if block_given?
      self.my_select { |x| yield(x) }.length.positive? ? (return true) : (return false)
    elsif !pattern.nil?
      if pattern.is_a?(Regexp)
        self.my_each { |x| return false if pattern.match(x.to_s) }
      elsif pattern.is_a?(Class)
        self.my_each { |x| return false if x.is_a?(pattern) }
      else
        self.my_each { |x| return false if x == pattern }
      end
    else
      self.my_each { |x| return false if x }
    end
    true
  end

  def my_count(elem = nil)
    total = 0
    if block_given?
      self.my_each { |x| total += 1 if yield(x) }
    elsif !elem.nil?
      self.my_each { |x| total += 1 if x == elem }
    else
      total = self.size
    end
    total
  end

  def my_map
    if block_given?
      return_arr = []
      self.my_each { |x| return_arr << yield(x) }
      return return_arr
    end
    to_enum(:my_map)
  end

  def my_inject(*args)
    result, sym = inj_param(*args)
    arr = result ? to_a : to_a[1..-1]
    result ||= to_a[0]
    if block_given?
      arr.my_each { |x| result = yield(result, x) }
    elsif sym
      arr.my_each { |x| result = result.public_send(sym, x) }
    end
    result
  end

  def inj_param(*args)
    result, sym = nil
    args.my_each do |arg|
      result = arg if arg.is_a? Numeric
      sym = arg unless arg.is_a? Numeric
    end
    [result, sym]
  end

  # rubocop:enable Style/RedundantSelf, Style/For
  # rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
end
def multiply_els(arr)
  arr.my_inject(:*)
end
