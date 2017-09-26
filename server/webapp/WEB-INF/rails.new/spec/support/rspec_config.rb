RSpec.configure do |config|
# Use color not only in STDOUT but also in pagers and files
  config.tty = true
  config.color = true

# config.add_formatter :documentation
  config.add_formatter :documentation
  config.include ApiSpecHelper
end

include JavaSpecImports
include JavaImports