require_relative 'paths'
require 'clavatar'
require 'minitest/autorun'

module TestClavatarParamReqKeyrestMod
  class KlassB
    attr_reader :b1
    attr_accessor :b2
    attr_writer :b3

    def initialize(b1, **args)
      @b1 = b1
      @b2 = args.fetch :b2, 0
    end

    def get_attr_b3
      @b3
    end
  end
end

class TestClavatarParamReqKeyrest < Minitest::Test
  def test_plain_attrs
    obj_b = TestClavatarParamReqKeyrestMod::KlassB.new(1)
    obj_b.b2 = 2
    obj_b.b3 = 3

    avatar = Clavatar.cast({b1: 4, b2: 5, b3: 6}, obj_b)
    assert avatar.b1 == 4
    assert avatar.b2 == 5
    assert avatar.get_attr_b3 == 6
  end
end
