# OptionsHash::MethodObject

A MethodObject with an OptionsHash built in

## Installation

Add this line to your application's Gemfile:

    gem 'options_hash-method_object'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install options_hash-method_object

## Usage

```ruby
class CreatePerson < OptionsHash::MethodObject

  required :name
  optional :favorite_color, default: ->{ 'blue' }

  def call
    build_person!
    validate_person!
    create_person!
    @person
  end

  def build_person!
    @person = Person.new(options.to_hash)
  end

  def validate_person!
    @person.valid? or raise 'invalid person'
  end

  def create_person!
    @person.save!
  end

end

```

**For details about the `require` and `optional` methods see [OptionsHash](https://github.com/deadlyicon/options_hash)**

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
