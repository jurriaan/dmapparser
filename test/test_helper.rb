require 'simplecov'
require 'coveralls'
SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]
SimpleCov.start do
  # add_filter '/test/'
end
gem 'minitest'
require 'minitest/autorun'
require 'minitest/hell'
require 'minitest/pride'

$TEST_DIR = __dir__
$ROOT_DIR = File.expand_path('..', $TEST_DIR)
$SUPPORT_DIR = File.join(__dir__, 'support/')
$LOAD_PATH.unshift File.join($ROOT_DIR, 'lib/')

require File.expand_path('../lib/dmapparser.rb', __dir__)
def support_file(name)
  open(File.join($SUPPORT_DIR, name))
end
