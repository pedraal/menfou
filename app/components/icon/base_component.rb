# frozen_string_literal: true

class Icon::BaseComponent < ViewComponent::Base
  def initialize(size = nil)
    @size = size
  end

  def svg_class
    "inline aspect-square #{@size || 'w-5'}"
  end
end
