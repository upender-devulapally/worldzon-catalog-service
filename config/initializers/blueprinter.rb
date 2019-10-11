# frozen_string_literal: true

# config/initializers/blueprinter.rb
# require 'oj'
# Oj (Optimized JSON) is fast. Faster than the built in Ruby json gem
# Oj achieves this by implementing the encoding and decoding of JSON in C, as a C extension to Ruby
Blueprinter.configure do |config|
  config.generator = Oj # Default is JSON
  config.sort_fields_by = :definition
  # config.datetime_format = ->(datetime) { datetime.nil? ? datetime : datetime.strftime('%s').to_i }
end

# sort fields in definition fix when associations are present
# View will ignore sort_fields_by: :definition
# https://github.com/procore/blueprinter/issues/172
# Blueprinter::Base.class_eval do
#   def self.view(view_name)
#     @current_view = view_collection[:default]
#     yield
#     @current_view = view_collection[view_name]
#   end
# end