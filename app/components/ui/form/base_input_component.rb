# frozen_string_literal: true

module Ui
  module Form
    class BaseInputComponent < ViewComponent::Base
      def initialize(form, field_name)
        @form = form
        @object = form.object
        @field_name = field_name
      end
    end
  end
end
