# frozen_string_literal: true

module Ui
  class MenuComponent < ViewComponent::Base
    renders_one :toggler
    renders_one :body
  end
end
