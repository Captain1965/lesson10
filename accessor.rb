# Написать модуль Acсessors, содержащий следующие методы, которые можно вызывать
# на уровне класса:
# метод
# attr_accessor_with_history
# Этот метод динамически создает геттеры и сеттеры для любого кол-ва атрибутов,
# при этом сеттер сохраняет все значения инстанс-переменной при изменении этого значения.
# Также в класс, в который подключается модуль должен добавляться инстанс-метод
# <имя_атрибута>_history
# который возвращает массив всех значений данной переменной.
# метод
# strong_attr_accessor
# который принимает имя атрибута и его класс. При этом создается геттер и сеттер
# для одноименной инстанс-переменной, но сеттер проверяет тип присваемоего значения.
# Если тип отличается от того, который указан вторым параметром, то выбрасывается
# исключение. Если тип совпадает, то значение присваивается.

module Accessors
  def self.included(base)
    base.extend ClassMethods
    # base.send :include, InstansMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*attr_array)
      attr_array.each do |name|
        name_method = "@#{name}".to_sym
        history = "@#{name}_history".to_sym
        define_method(name) { instance_variable_get(name_method) }
        define_method("#{name}_history") { instance_variable_get(history).each { |value| puts value } }
        define_method("#{name}=".to_sym) do |value|
          instance_variable_set(name_method, value)
          history_values = instance_variable_get(history) || []
          instance_variable_set(history, history_values << value)
        end
      end
    end

    def strong_attr_accessor(attr_name, class_name)
      name_method = "@#{attr_name}".to_sym
      class_name = class_name.to_s.capitalize
      puts class_name
      define_method(attr_name) {instance_variable_get(name_method)}
      define_method("#{attr_name}=".to_sym) do |value|
        raise 'type is error' unless value.is_a?(Kernel.const_get(class_name))
        instance_variable_set(name_method, value)
      rescue Exception => e
        puts e.inspect
      end
    end
  end
end

class Test
  include Accessors
   attr_accessor_with_history :a, :b, :c
   test = Test.new
   test.a = 2
   test.b = 3
   test.c = 4
   puts test.a
   puts test.b
   puts test.c
   test.a = 5
   test.a = 6
   puts test.a_history.inspect

   strong_attr_accessor :f, :integer
   test = Test.new
   test.f = 5
   puts test.f
end


