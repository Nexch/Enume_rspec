# spec/test_spec.rb
require_relative '../main'

describe Enumerable do
  include Enumerable

  describe 'my_each' do
    it 'each string and block' do
      expect(%w[Sharon Leo Leila Brian Arun].my_each { |friend| puts friend } == %w[Sharon Leo Leila Brian Arun].each { |friend| puts friend }).to be true
    end

    it 'each range' do
      expect((1..3).each { |friend| puts friend } == (1..3).my_each { |friend| puts friend }).to be true
    end

    it 'each index' do
      expect(%w[Sharon Leo Leila Brian Arun].my_each_with_index { |friend, index| print "#{friend} #{index} \n" } == %w[Sharon Leo Leila Brian Arun].each_with_index { |friend, index| print "#{friend} #{index} \n" }).to be true
    end
  end

  describe 'my_select' do
    it 'select block' do
      expect(%w[Sharon Leo Leila Brian Arun].my_select { |friend| friend != 'Brian' } == %w[Sharon Leo Leila Brian Arun].reject { |friend| friend == 'Brian' }).to be true
    end

    it 'select no block' do
      expect([1, 2, 3].my_select.class).to eq Enumerator
    end
  end

  describe 'my_all' do
    it 'all block' do
      expect(%w[Sharon Leo Leila Brian Arun].my_all? { |word| word.length >= 3 } == %w[Sharon Leo Leila Brian Arun].all? { |word| word.length >= 3 }).to be true
    end

    it 'all no block' do
      expect([1, 2, 3].my_all?).to be true
    end

    it 'all /t/' do
      expect(%w[ant bear cat].my_all?(/t/) == %w[ant bear cat].all?(/t/)).to be true
    end

    it 'all class' do
      expect([1, 2, 3].my_all?(Float) == [1, 2, 3].all?(Float)).to be true
    end

    it 'all nill' do
      expect([nil, true, 99].my_all? == [nil, true, 99].all?).to be true
    end

    it 'all emty' do
      expect([].my_all? == [].all?).to be true
    end

    it 'all true' do
      expect([true, true, true].my_all? == [true, true, true].all?).to be true
    end

    it 'all false' do
      expect([false, false, false].my_all? == [false, false, false].all?).to be true
    end

    it 'all true array' do
      expect([true, [true], true].my_all? == [true, [true], true].all?).to be true
    end

    it 'all class num' do
      expect([1, -2, 3.4].all?(Numeric) == [1, -2, 3.4].my_all?(Numeric)).to be true
    end

    it 'all class int' do
      expect(['word', 1, 2, 3].all?(Integer) == ['word', 1, 2, 3].my_all?(Integer)).to be true
    end

    it 'all /a/' do
      expect(%w[cat cat].my_all?(/a/) == %w[cat cat].all?(/a/)).to be true
    end

    it 'all 5' do
      expect([5, 5, 5].all?(5) == [5, 5, 5].my_all?(5)).to be true
    end

    it 'all 5 array' do
      expect([5, [5], 5].all?(5) == [5, [5], 5].my_all?(5)).to be true
    end
  end

  describe 'my_any' do
    it 'any no block' do
      expect([1, 2, 3].my_any?).to be true
    end

    it 'any block' do
      expect([1, 2, 3].any?(&proc { |x| x.even? }) == [1, 2, 3].my_any?(&proc { |x| x.even? })).to be true
    end

    it 'any range' do
      expect((1..3).any?(&proc { |x| x.zero? }) == (1..3).my_any?(&proc { |x| x.zero? })).to be true
    end

    it 'any class' do
      expect([1.1, '', []].any?(Numeric) == [1.1, '', []].my_any?(Numeric)).to be true
    end

    it 'any /d/' do
      expect(%w[dog cat].any?(/d/) == %w[dog cat].my_any?(/d/)).to be true
    end

    it 'any' do
      expect(%w[cat dog car].any?('cat') == %w[cat dog car].my_any?('cat')).to be true
    end
  end

  describe 'my_none' do
    it 'none no block' do
      expect([1, 2, 3].my_none?).to be true
    end

    it 'none range' do
      expect((1..3).none?(&proc { |num| num.even? }) == (1..3).my_none?(&proc { |num| num.even? })).to be true
    end

    it 'none' do
      expect([false, nil, []].none? == [false, nil, []].my_none?).to be true
    end

    it 'none class' do
      expect([true, []].none?(String) == [true, []].my_none?(String)).to be true
    end

    it 'none /d/' do
      expect(%w[dog cat].none?(/x/) == %w[dog cat].my_none?(/x/)).to be true
    end
  end

  describe 'my_count' do
    it 'count no block' do
      expect([1, 2, 3].my_count).to be 3
    end

    it 'count range' do
      expect((1..3).count == (1..3).my_count).to be true
    end

    it 'count nil' do
      expect([nil, nil, nil, 2, 4].count(nil) == [nil, nil, nil, 2, 4].my_count(nil)).to be true
    end
  end

  describe 'my_inject' do
    it 'inject' do
      expect([1, 2, 3, 4, 5, 6, 7, 8, 9].my_inject { |sum, n| sum + n } == [1, 2, 3, 4, 5, 6, 7, 8, 9].inject { |sum, n| sum + n }).to be true
    end

    it 'inject range' do
      expect((1..3).inject(&proc { |total, num| total * num }) == (1..3).my_inject(&proc { |total, num| total * num })).to be true
    end

    it 'inject :+' do
      expect([1, 2, 3].inject(:+) == [1, 2, 3].my_inject(:+)).to be true
    end

    it 'multiply using inject' do
      expect(multiply_els([1, 2, 3])).to be 6
    end
  end

  describe 'my_map' do
    it 'map' do
      expect([1, 2, 3].map { |i| i * i } == [1, 2, 3].my_map { |i| i * i }).to be true
    end

    it 'map proc' do
      expect([1, 2, 3].my_map(proc { |x| x % 2 }) { |a| a * 2 } == [1, 2, 3].my_map(proc { |x| x % 2 })).to be true
    end

    it 'map range' do
      expect((1..3).map(&proc { |num| num + 1 }) == (1..3).my_map(&proc { |num| num + 1 })).to be true
    end

    it 'map class' do
      expect([1, 2, 3].map.class == [1, 2, 3].my_map.class).to be true
    end
  end
end
