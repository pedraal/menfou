# frozen_string_literal: true

module Ui
  module Form
    class BaseInputComponent < ViewComponent::Base
      def initialize(form, field_name, **options)
        @form = form
        @object = form.object
        @field_name = field_name
        @options = options
      end
    end
  end
end
