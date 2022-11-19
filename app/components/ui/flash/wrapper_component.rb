# frozen_string_literal: true

module Ui
  module Flash
    class WrapperComponent < ViewComponent::Base
      renders_one :body
    end
  end
end
