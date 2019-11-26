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
      
end

myarr = [2, 2, 3, 4]
myWords = ['this', 'that', 'theOther']
puts 'add'
puts myarr.my_inject{|x,y| x + y}
puts 'multiply'
puts multiply_els(myarr)