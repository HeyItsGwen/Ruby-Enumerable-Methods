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

  def my_none?(pattern = nil)
    if block_given?
      self.my_select{|x| yield(x)}.length.positive? ? (return true) : (return false)
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

  def my_map
    unless !block_given? 
      returnArr = []
      self.my_each{|x| returnArr << yield(x)}
      return returnArr
    end
    to_enum(:my_map)
  end

  def my_inject
    j=1
    self.my_each{|x| j = yield(j,x)}
    return j
  end
      
end

def multiply_els(arr)

  include Enumerable
    arr.my_inject{|x,y| x * y}

end

myarr = [1, 2, 3, 4]
myWords = ['this', 'that', 'theOther']
mystring = 'hello there friends'

myarr.my_each