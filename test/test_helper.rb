# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'faker'

class ActiveSupport::TestCase
  parallelize(workers: :number_of_processors)

  fixtures :all
end
