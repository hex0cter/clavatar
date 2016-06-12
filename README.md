# The clavatar gem for Ruby

[![Gem Version](https://badge.fury.io/rb/clavatar.svg)](https://badge.fury.io/rb/clavatar)
[![Build Status](https://travis-ci.org/hex0cter/clavatar.svg?branch=master)](https://travis-ci.org/hex0cter/clavatar)
[![Coverage Status](https://coveralls.io/repos/github/hex0cter/clavatar/badge.svg?branch=master)](https://coveralls.io/github/hex0cter/clavatar?branch=master)

Clavatar is a ruby gem that convert a a hash into a Ruby class instance.

During the web development, it is common to transfer json between the browser and the server. When the json from the
browser presents an object, you might need to convert this json (which is presented by the server as a hash) into a Ruby
object.

Normally the class you wanna convert to has to provide a method or constructor that takes a hash as parameter. In that
way you will have to do the same for all the classes.

Clavatar provides another solution for this. When you want to convert a json (hash) into the object, you just need to
provide the class name and a hash. As Ruby is a dynamic language, an existing instance of the same class is provided as
an example.

When you call

```ruby
Clavatar.cast(hash, class, example)
```

clavatar will first inspect all the internal data and find out which are writable (for instance, attr_accessor,
attr_writer, etc.) and which are not (for instance, attr_reader, private members, etc).

For those that are not writable, clavatar attemps to call its constructor using the information provided by the hash.
As a constructor can be written in any way (for example, the order of parameters can be in any order), clavatar assumes
the following syntax is used in the class's constructor:

```ruby
class A
    def initialize(param1:, [**args])
        ...
    end
end
```

Once a new instance is created, clavatar just copies all the other accessible data to the new instance.

```ruby
module A
  class KlassB
    attr_reader :b1
    attr_accessor :b2
    attr_writer :b3

    def initialize(b1:)
      @b1 = b1
    end

    def get_attr_b3
      @b3
    end
  end
end

class TestClavatar1 < Minitest::Test
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

```
