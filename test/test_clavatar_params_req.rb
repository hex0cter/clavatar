require_relative 'paths'
require 'clavatar'
require 'minitest/autorun'

module TestClavatarParamReqMod
  class KlassB
    attr_reader :b1
    attr_accessor :b2
    attr_writer :b3

    def initialize(b1)
      @b1 = b1
    end

    def get_attr_b3
      @b3
    end

    def set_another_attribute
      @b4 = 'something'
    end
  end
end

class TestClavatarParamReq < Minitest::Test
  def test_plain_attrs
    obj_b = TestClavatarParamReqMod::KlassB.new(1)
    obj_b.b2 = 2
    obj_b.b3 = 3
    obj_b.set_another_attribute

    avatar = Clavatar.cast({b1: 4, b2: 5, b3: 6}, TestClavatarParamReqMod::KlassB, obj_b)
    assert avatar.b1 == 4
    assert avatar.b2 == 5
    assert avatar.get_attr_b3 == 6
  end
end
