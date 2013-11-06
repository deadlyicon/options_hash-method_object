require 'spec_helper'

class CreatePerson < OptionsHash::MethodObject

  required :name
  optional :favorite_color, default: ->{ 'blue' }

  def call
    options
  end

end

class CreateRobot < CreatePerson

  required :model_number

  def call
    [name, favorite_color, model_number]
  end

end

describe OptionsHash::MethodObject do
  subject{ OptionsHash::MethodObject }

  it { should_not respond_to :call         }
  it { should_not respond_to :options_hash }
  it { should_not respond_to :required     }
  it { should_not respond_to :optional     }
  it { should_not respond_to :options      }

  describe CreatePerson do
    describe '.call' do
      it 'should take one optional argument' do
        expect( CreatePerson.method(:call).arity ).to eq -1
        expect{ CreatePerson.call }.to raise_error ArgumentError, 'required options: :name'
        expect{ CreatePerson.call name: 'Jared' }.to_not raise_error
        options = CreatePerson.call name: 'Jared'
        expect(options.name).to eq 'Jared'
        expect(options.favorite_color).to eq 'blue'
      end
    end
    describe '.options' do
      it 'should return a hash of the possible arguments' do
        expect( CreatePerson.options.keys.to_set ).to eq Set[:favorite_color, :name]
        expect( CreatePerson.options[:name] ).to be_required
        expect( CreatePerson.options[:favorite_color] ).to_not be_required
      end
    end
  end

  it 'should be subclassable' do
    expect( CreateRobot.options.keys.to_set ).to eq Set[:favorite_color, :name, :model_number]
    expect{ CreateRobot.call }.to raise_error ArgumentError, 'required options: :model_number, :name'
    expect( CreateRobot.call(name: 'Hal', model_number: 14) ).to eq ['Hal', 'blue', 14]
  end

end
