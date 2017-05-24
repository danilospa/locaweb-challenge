# frozen_string_literal: true
module Resourceable
  def to_h
    instance = self
    methods(instance.class).each_with_object({}) do |method, result|
      result[method.to_s] = instance.send(method)
    end
  end

  private

  def methods(klass)
    methods = klass.instance_methods(false)
    methods = methods.concat(klass.superclass.instance_methods(false)) unless klass.superclass == Object
    methods - [:to_h]
  end
end
