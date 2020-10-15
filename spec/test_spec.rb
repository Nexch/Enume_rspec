# spec/test_spec.rb
require_relative '../main'

describe Enumerable do
  include Enumerable

  describe 'my_each' do
    it 'each check for string and block' do
      expect(%w[Sharon Leo Leila Brian Arun].my_each { |friend| puts friend } == %w[Sharon Leo Leila Brian Arun].each { |friend| puts friend }).to be true
    end

    it 'each check for range' do
      expect((1..3).each { |friend| puts friend } == (1..3).my_each { |friend| puts friend }).to be true
    end
  end

  describe 'my_each check for with index' do
    it 'each index' do
      expect(%w[Sharon Leo Leila Brian Arun].my_each_with_index { |friend, index| print "#{friend} #{index} \n" } == %w[Sharon Leo Leila Brian Arun].each_with_index { |friend, index| print "#{friend} #{index} \n" }).to be true
    end
  end

  describe 'my_select' do
    it 'select check for block' do
      expect(%w[Sharon Leo Leila Brian Arun].my_select { |friend| friend != 'Brian' } == %w[Sharon Leo Leila Brian Arun].reject { |friend| friend == 'Brian' }).to be true
    end

    it 'select check for no block' do
      expect([1, 2, 3].my_select.class).to eq Enumerator
    end
  end

  describe 'my_all' do
    it 'all check for block' do
      expect(%w[Sharon Leo Leila Brian Arun].my_all? { |word| word.length >= 3 } == %w[Sharon Leo Leila Brian Arun].all? { |word| word.length >= 3 }).to be true
    end

    it 'all check for false number 1' do
      expect([nil, true, 99].all?).to be false
    end

    it 'all check for false number 2' do
      expect(%w[ant bear cat].all?(/t/)).to be false
    end

    it 'all check for no block' do
      expect([1, 2, 3].my_all?).to be true
    end

    it 'all check for /t/' do
      expect(%w[ant bear cat].my_all?(/t/) == %w[ant bear cat].all?(/t/)).to be true
    end

    it 'all check for class' do
      expect([1, 2, 3].my_all?(Float) == [1, 2, 3].all?(Float)).to be true
    end

    it 'all check for nill' do
      expect([nil, true, 99].my_all? == [nil, true, 99].all?).to be true
    end

    it 'all check for emty' do
      expect([].my_all? == [].all?).to be true
    end

    it 'all check for true' do
      expect([true, true, true].my_all? == [true, true, true].all?).to be true
    end

    it 'all check for false' do
      expect([false, false, false].my_all? == [false, false, false].all?).to be true
    end

    it 'all check for true array' do
      expect([true, [true], true].my_all? == [true, [true], true].all?).to be true
    end

    it 'all check for class num' do
      expect([1, -2, 3.4].all?(Numeric) == [1, -2, 3.4].my_all?(Numeric)).to be true
    end

    it 'all check for class int' do
      expect(['word', 1, 2, 3].all?(Integer) == ['word', 1, 2, 3].my_all?(Integer)).to be true
    end

    it 'all check for /a/' do
      expect(%w[cat cat].my_all?(/a/) == %w[cat cat].all?(/a/)).to be true
    end

    it 'all check for 5' do
      expect([5, 5, 5].all?(5) == [5, 5, 5].my_all?(5)).to be true
    end

    it 'all check for 5 array' do
      expect([5, [5], 5].all?(5) == [5, [5], 5].my_all?(5)).to be true
    end
  end

  describe 'my_any' do
    it 'any check for false number 1' do
      expect([].my_any?).to be false
    end

    it 'any check for false number 2' do
      expect(%w[ant bear cat].my_any?(/d/)).to be false
    end

    it 'any check for no block' do
      expect([1, 2, 3].my_any?).to be true
    end

    it 'any check for block' do
      expect([1, 2, 3].any?(&proc { |x| x.even? }) == [1, 2, 3].my_any?(&proc { |x| x.even? })).to be true
    end

    it 'any check for range' do
      expect((1..3).any?(&proc { |x| x.zero? }) == (1..3).my_any?(&proc { |x| x.zero? })).to be true
    end

    it 'any check for class' do
      expect([1.1, '', []].any?(Numeric) == [1.1, '', []].my_any?(Numeric)).to be true
    end

    it 'any check for /d/' do
      expect(%w[dog cat].any?(/d/) == %w[dog cat].my_any?(/d/)).to be true
    end

    it 'any check if any is inside' do
      expect(%w[cat dog car].any?('cat') == %w[cat dog car].my_any?('cat')).to be true
    end
  end

  describe 'my_none' do
    it 'none check for false number 1' do
      expect([nil, false, true].my_none?).to be false
    end

    it 'none check for false number 2' do
      expect([1, 3.14, 42].my_none?(Float)).to be false
    end

    it 'none check for no block' do
      expect([1, 2, 3].my_none?).to be true
    end

    it 'none check for range' do
      expect((1..3).none?(&proc { |num| num.even? }) == (1..3).my_none?(&proc { |num| num.even? })).to be true
    end

    it 'none check if none in empty array' do
      expect([false, nil, []].none? == [false, nil, []].my_none?).to be true
    end

    it 'none check for class' do
      expect([true, []].none?(String) == [true, []].my_none?(String)).to be true
    end

    it 'none check for /d/' do
      expect(%w[dog cat].none?(/x/) == %w[dog cat].my_none?(/x/)).to be true
    end
  end

  describe 'my_count' do
    it 'count check for no block' do
      expect([1, 2, 3].my_count).to be 3
    end

    it 'count check for range' do
      expect((1..3).count == (1..3).my_count).to be true
    end

    it 'count check for nil' do
      expect([nil, nil, nil, 2, 4].count(nil) == [nil, nil, nil, 2, 4].my_count(nil)).to be true
    end
  end

  describe 'my_inject' do
    it 'inject compared whit my inject return true if there are equal' do
      expect([1, 2, 3, 4, 5, 6, 7, 8, 9].my_inject { |sum, n| sum + n } == [1, 2, 3, 4, 5, 6, 7, 8, 9].inject { |sum, n| sum + n }).to be true
    end

    it 'inject check for range' do
      expect((1..3).inject(&proc { |total, num| total * num }) == (1..3).my_inject(&proc { |total, num| total * num })).to be true
    end

    it 'inject check for :+' do
      expect([1, 2, 3].inject(:+) == [1, 2, 3].my_inject(:+)).to be true
    end
  end

  describe 'multiple els' do
    it 'multiply check for the correct value using inject' do
      expect(multiply_els([1, 2, 3])).to be 6
    end
  end
  describe 'my_map' do
    it 'map check if my_map equal to map return true if they are equal' do
      expect([1, 2, 3].map { |i| i * i } == [1, 2, 3].my_map { |i| i * i }).to be true
    end

    it 'map check for proc' do
      expect([1, 2, 3].my_map(proc { |x| x % 2 }) { |a| a * 2 } == [1, 2, 3].my_map(proc { |x| x % 2 })).to be true
    end

    it 'map check for range' do
      expect((1..3).map(&proc { |num| num + 1 }) == (1..3).my_map(&proc { |num| num + 1 })).to be true
    end

    it 'map check for class' do
      expect([1, 2, 3].map.class == [1, 2, 3].my_map.class).to be true
    end
  end
end
