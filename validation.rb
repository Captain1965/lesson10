# Написатьмодуль validation
# Содержит метод класса validate. Этот метод принимает в качестве параметров имя
# проверяемого атрибута, а также тип валидации и при необходимости дополнительные
# параметры.Возможные типы валидаций:
# - presence - требует, чтобы значение атрибута было не nil и не пустой строкой.
# Пример использования:
# validate :name, :presence
# - format (при этом отдельным параметром задается регулярное выражение для формата).
# Требует соответствия значения атрибута заданному регулярному выражению. Пример:
# validate :number, :format, /A-Z{0,3}/
# - type (третий параметр - класс атрибута). Требует соответствия значения атрибута
# заданному классу. Пример:
# validate :station, :type, RailwayStation
# Содержит инстанс-метод validate!, который запускает все проверки (валидации),
# указанные в классе через метод класса validate. В случае ошибки валидации выбрасывает
# исключение с сообщением о том, какая именно валидация не прошла
# Содержит инстанс-метод valid? который возвращает true, если все проверки валидации
# прошли успешно и false, если есть ошибки валидации.
# К любому атрибуту можно применить несколько разных валидаторов, например
# validate :name, :presence
# validate :name, :format, /A-Z/
# validate :name, :type, String
# Все указанные валидаторы должны применяться к атрибуту
# Допустимо, что модуль не будет работать с наследниками.

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanseMethods
  end

  module ClassMethods
    def validate(name, type,*param)
      @validate ||=[]
      @validate << {name: name, type: type, param: param}
    end
  end

  module InstanseMethods
    def valid?
      validate!
      true
    rescue RuntimeError => e
      puts e
      false
    end

    def validate!
      self.class.instance_variable_get("@validate").each do |hash|
        name = hash[:name]
        value = instance_variable_get("@#{name}")
        type = hash[:type]
        param = hash[:param][0]
        send("validate_#{type}", name, value, param)
      end
    end

    def validate_presence(name, value, _)
      raise "#{name} must be defined!" if value.nil? || value.to_s.empty?
    end

    def validate_format(name, value, regexp)
       raise "Format #{name} invalid " if value !~ regexp
    end

    def validate_type(name, value, type)
     raise "Type #{name} must be #{type}" unless value.is_a?(type)
    end
  end
end

# class Test
#   include Validation
#   PATTERN = /^([А-Я])([а-я]){1,}/
#   validate :name, :format, :PATTERN
#   def initialize(name)
#   @name = name
#   valid?
#  end
# end
# test = Test.new('Москва')








