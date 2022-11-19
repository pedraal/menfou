# frozen_string_literal: true

module Ui
  module Flash
    class NoticeComponent < ViewComponent::Base
      def initialize(body)
        @body = body
      end
    end
  end
end
