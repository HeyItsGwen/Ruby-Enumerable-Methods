# frozen_string_literal: true
# rubocop:disable Style/LineLength, Style/RedundantSelf, Style/StringLiterals, Style/For

module Enumerable
#done
  def my_each
    if block_given?
      for i in 0...self.length
        yield( self [i] )
      end
    else
      to_enum(:my_each)
    end
  end
#done
  def my_each_with_index
    if block_given?
      for i in 0...self.length
        yield( self[i], i)
      end
    else
      to_enum(:my_each_with_index)
    end
  end
#done
  def my_select
    if block_given?
      returnArr = []
      self.my_each{ |x| returnArr << x if yield(x) }
      returnArr.nil? ? (return false) : (return returnArr)
    else
      to_enum(:my_select)
    end
  end
#done
  def my_all?(pattern = nil)
    if block_given?
      self.my_select{ |x| yield(x) }.length === self.length ? (return true) : (return false)
    elsif !pattern.nil?
      if pattern.is_a?(Regexp)
        self.my_each{ |x| return false unless pattern.match(x.to_s) }
      elsif pattern.is_a?(Class)
        self.my_each{ |x| return false unless x.is_a?(pattern) }
      else
        self.my_each{ |x| return false unless x == pattern }
      end
    else
      self.my_each{ |x| return false unless x}
    end
    true
  end
#done
  def my_any?(pattern = nil)
    if block_given?
      self.my_select{ |x| yield(x) }.length.positive? ? (return true) : (return false)
    elsif !pattern.nil?
      if pattern.is_a?(Regexp)
        self.my_each{ |x| return true if pattern.match(x.to_s) }
      elsif pattern.is_a?(Class)
        self.my_each{ |x| return true if x.is_a?(pattern) }
      else
        self.my_each{ return true if x==pattern }
      end
    else
      self.my_each{ |x| return true if x }    
    end
    false
  end
#done
  def my_none?(pattern = nil)
    if block_given?
      self.my_select{|x| yield(x)}.length.positive? ? (return false) : (return true)
    elsif !pattern.nil?
      if pattern.is_a?(Regexp)
        self.my_each{ |x| return false if pattern.match(x.to_s)}
      elsif pattern.is_a?(Class)
        self.my_each{ |x| return false if x.is_a?(pattern)}
      else 
        self.my_each{ |x| return false if x == pat }
      end
    else
      self.my_each{ |x| return false if x}
    end
    true
  end
#done
  def my_count(elem = nil)
    return self.length unless block_given?
    if elem.nil?
      return self.my_select{ |x| yield(x) }.length 
    else
      count = 0
      self.my_each{ |x| count += 1 if x == elem }
      return count
    end
  end
#done
  def my_map
    unless !block_given? 
      returnArr = []
      self.my_each{|x| returnArr << yield(x)}
      return returnArr
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
      
end

def multiply_els(arr)

  include Enumerable
    arr.my_inject(:*)

end

myarr = [1, 2, 3, 4]
myWords = ['this', 'that', 'theOther']
mystring = 'hello there friends'

puts myarr.my_inject(1){|x,y|x*y}