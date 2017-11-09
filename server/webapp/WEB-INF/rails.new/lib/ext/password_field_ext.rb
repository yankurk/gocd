# See https://github.com/ketan/gocd/commit/52ac14d21b9b4595df82f5b0391a57c0cfca1bc6
# Patches PasswordField to render plain text value :-(
require 'action_view/helpers/tags/password_field'
module ActionView
  module Helpers
    module Tags # :nodoc:
      class PasswordField < TextField # :nodoc:
        def render
          # This line is intentionally commented out
          # @options = { value: nil }.merge!(@options)
          super
        end
      end
    end
  end
end
