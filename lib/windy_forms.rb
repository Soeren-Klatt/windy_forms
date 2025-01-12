# frozen_string_literal: true

require_relative "windy_forms/version"
require "windy_forms/engine"

module WindyForms
  class Error < StandardError; end

  autoload :FormBuilder, "windy_forms/form_builder"

  module Helper
    def windy_form_for(record, options = {}, &block)
      options[:builder] ||= WindyForms::FormBuilder
      form_for(record, options, &block)
    end
  end
end
