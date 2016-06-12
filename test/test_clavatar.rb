require_relative 'paths'
require 'clavatar'
require 'minitest/autorun'

class KlassA
  attr_reader :a1
  attr_accessor :a2
  attr_writer :a3

  def initialize(**args)
    @a1 = args.fetch :a1
  end

  def get_attr_a3
    @a3
  end
end

class TestClavatar < Minitest::Test
  def test_plain_attrs
    obj_a = KlassA.new(a1: 1)
    obj_a.a2 = 2
    obj_a.a3 = 3

    avatar = Clavatar.cast({a1: 4, a2: 5, a3: 6}, KlassA, obj_a)
    assert avatar.a1 == 4
    assert avatar.a2 == 5
    assert avatar.get_attr_a3 == 6
  end

  def test_array_attrs
    obj_a = KlassA.new(a1: [1, 2, 3])
    obj_a.a2 = [2, 3, 4]
    obj_a.a3 = [3, 4, 5]

    avatar = Clavatar.cast({a1: [:a, :b, :c], a2: [:b, :c, :d], a3: [:c, :d, :e]}, KlassA, obj_a)
    assert avatar.a1 == [:a, :b, :c]
    assert avatar.a2 == [:b, :c, :d]
    assert avatar.get_attr_a3 == [:c, :d, :e]
  end

  def test_hash_attrs
    obj_a = KlassA.new(a1: {a1: 1})
    obj_a.a2 = {a2: 2}
    obj_a.a3 = {a3: 3}

    avatar = Clavatar.cast({a1: {x: 4}, a2: {y: 5}, a3: {z: 6}}, KlassA, obj_a)
    assert avatar.a1 == {x: 4}
    assert avatar.a2 == {y: 5}
    assert avatar.get_attr_a3 == {z: 6}
  end
end
