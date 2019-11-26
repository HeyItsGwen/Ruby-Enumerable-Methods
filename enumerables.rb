# frozen_string_literal: true

module Enumerable

  def my_each
    for i in 0...self.length
      yield( self[i] )
    end
  end

  def my_each_with_index
    for i in 0...self.length
      yield( self[i], i)
    end
  end

  def my_select
    returnArr = []
    self.my_each{|x| returnArr << x if yield(x)}
    returnArr.nil? ? (return 'nothing') : (return returnArr)
  end

  def my_all?
    self.my_select{|x| yield(x)}.length === self.length ? true : false
  end

  def my_any?
    self.my_select{|x| yield(x)}.length > 0 ? true : false
  end

  def my_none?
    self.my_select{|x| yield(x)}.length > 0 ? false : true
  end

  def my_count
    return self.length unless block_given?
    return self.my_select{|x| yield(x)}.length 
  end

  def my_map
    returnArr = []
    self.my_each{|x| returnArr << yield(x)}
    return returnArr
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

myarr = [2, 2, 3, 4]
myWords = ['this', 'that', 'theOther']
puts 'add'
puts myarr.my_inject{|x,y| x + y}
puts 'multiply'
puts multiply_els(myarr)