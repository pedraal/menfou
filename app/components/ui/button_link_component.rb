# frozen_string_literal: true

module Ui
  class ButtonLinkComponent < ViewComponent::Base
    renders_one :icon

    def initialize(label, link)
      @label = label
      @link = link
    end
  end
end
