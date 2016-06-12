require_relative 'paths'
require 'clavatar'
require 'minitest/autorun'

module A
  class KlassB
    attr_reader :b1
    attr_accessor :b2
    attr_writer :b3

    def initialize(**args)
      @b1 = args.fetch :b1
      @b2 = args.fetch :b2, 0
    end

    def get_attr_b3
      @b3
    end
  end
end

class TestClavatar3 < Minitest::Test
  def test_plain_attrs
    obj_b = A::KlassB.new(b1: 1)
    obj_b.b2 = 2
    obj_b.b3 = 3
    obj_b.set_another_attribute

    avatar = Clavatar.cast({b1: 4, b2: 5, b3: 6}, A::KlassB, obj_b)
    assert avatar.b1 == 4
    assert avatar.b2 == 5
    assert avatar.get_attr_b3 == 6
  end
end
