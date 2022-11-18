# frozen_string_literal: true

module Ui
  class ModalComponent < ViewComponent::Base
    renders_one :body

    def initialize(id: nil)
      @id = id
    end
  end
end
