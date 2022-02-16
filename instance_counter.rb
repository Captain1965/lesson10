# encoding utf-8
# module InsanseCounter contain methods ClassMethods and InstancaeMethods
module InstanceCounter
  def self.included(name)
    name.extend ClassMethods
    name.include InstanceMethods
  end

  # module ClassMethods counts the number of instances of the class
  module ClassMethods
    def instances
      @instances ||= 0
      @instances += 1
    end
  end

  # module InstanseMethods increases the count of the number of instances of the
  # class and can be called from the constructor.
  module InstanceMethods
    private

    def register_instances
      self.class.instances
    end
  end
end
