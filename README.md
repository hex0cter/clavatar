# The clavatar gem for Ruby

[![Gem Version](https://badge.fury.io/rb/clavatar.svg)](https://badge.fury.io/rb/clavatar)
[![Build Status](https://travis-ci.org/hex0cter/clavatar.svg?branch=master)](https://travis-ci.org/hex0cter/clavatar)

Clavatar is a ruby gem that converts a hash into a Ruby object.

During the web development, it is common to transfer json between the browser and the server. When the json from the
browser presents an object, you might need to convert it (which is presented by the server as a hash) back into a Ruby
object.

Normally the class you want to convert to has to provide a method or constructor that takes a hash as argument. In that
way you will have to implement the same interface for all the classes.

Clavatar provides another solution for this. When you want to convert a json (hash) into the object, you just need to
provide the class name and a hash. As Ruby is a dynamic language, an existing instance of the same class is provided as
an example.

When you call

```ruby
Clavatar.cast(hash, class, example)
```

clavatar will first inspect all the internal data of example and find out which are writable (for instance,
attr_accessor, attr_writer, etc.) and which are not (for instance, attr_reader, private members, etc).

For those that are not writable, clavatar attemps to call its constructor using the information provided by the hash.
At the moment clavatar supports the class constructor in any of the following forms:

```ruby
class A
    def initialize([param_1, param_2, ...] [param_x:, param_y:, ...] [**args])
        ...
    end
end
```

Once a new instance is created, clavatar just copies all the other accessible data to the new instance.

Below is an example of how to use clavatar:

```ruby
module TestModule
  class MyKlass
    attr_reader :b1
    attr_reader :b2
    attr_reader :b3
    attr_reader :b4
    attr_writer :b5
    attr_writer :b6

    def initialize(b1, b2 = 2, b3:, b4: 4, **args)
      @b1 = b1
      @b2 = b2
      @b3 = b3
      @b4 = b4
      @b5 = args.fetch :b5, 0
      @b6 = args.fetch :b6, 0
    end

    def get_attr_b5
      @b5
    end

    def get_attr_b6
      @b6
    end
  end
end

class TestClavatarMixedParams < Minitest::Test
  def test_plain_attrs
    my_obj = TestModule::MyKlass.new(1, b3: 3, b5:5)
    my_obj.b6 = 6

    my_obj_avatar = Clavatar.cast({b1: 11, b2: 12, b3: 13, b4: 14, b5: 15, b6: 16}, TestModule::MyKlass, my_obj)
    assert my_obj_avatar.b1 == 11
    assert my_obj_avatar.b2 == 12
    assert my_obj_avatar.b3 == 13
    assert my_obj_avatar.b4 == 14
    assert my_obj_avatar.get_attr_b5 == 15
    assert my_obj_avatar.get_attr_b6 == 16
  end
end
```

## How to install?

From a terminal run

```bash
  gem install clavatar
```

or add the following code into your Gemfiles:

```ruby
  gem 'clavatar'
```

## License

This code is free to use under the terms of the MIT license.

## Contribution

You are more than welcome to raise any issues [here](https://github.com/hex0cter/clavatar/issues), or create a Pull Request.
