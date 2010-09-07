# create a new file inside lib/ and call it helpers.rb
# paste the following:

def help
  Helper.instance
end

class Helper
  include Singleton
  # look inside ActionView::Helpers to include any other helpers that you might need
  include ActionView::Helpers::DateHelper
  include ActionView::Helpers::TextHelper
end

# then in any model or controller:
# require 'lib/helpers'

# to use:
# help.name_of_helper
# EX: help.pluralize 10, "person"