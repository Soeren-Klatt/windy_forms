# frozen_string_literal: true

module WindyForms
  class FormBuilder < ActionView::Helpers::FormBuilder
    # Define default Tailwind classes
    INPUT_CLASS = "border-gray-300 rounded-lg shadow-sm focus:border-indigo-500 focus:ring focus:ring-indigo-200 focus:ring-opacity-50"
    ERROR_CLASS = "border-red-500"
    LABEL_CLASS = "block text-sm font-medium text-gray-700"
    ERROR_TEXT_CLASS = "text-red-600 text-sm mt-1"

    # Automatically add a label unless disabled
    def text_field(method, options = {})
      render_field_with_label(method, :text_field, options)
    end

    def email_field(method, options = {})
      render_field_with_label(method, :email_field, options)
    end

    def password_field(method, options = {})
      render_field_with_label(method, :password_field, options)
    end

    private

    def render_field_with_label(method, field_type, options = {})
      label_enabled = options.delete(:label) != false
      label_text = options.delete(:label_text) || method.to_s.humanize

      field_html = send(field_type, method, prepare_input_options(method, options))

      html = ""
      html += label(method, label_text, class: LABEL_CLASS) if label_enabled
      html += wrap_with_error_handling(method, field_html)

      html.html_safe
    end

    def prepare_input_options(method, options)
      options[:class] = combine_classes(options[:class], INPUT_CLASS, error_class(method))
      options
    end

    def wrap_with_error_handling(method, field_html)
      if object.errors[method].any?
        <<-HTML
          <div class="mb-4">
            #{field_html}
            <p class="#{ERROR_TEXT_CLASS}">
              #{object.errors[method].join(', ')}
            </p>
          </div>
        HTML
      else
        <<-HTML
          <div class="mb-4">
            #{field_html}
          </div>
        HTML
      end
    end

    def combine_classes(*classes)
      classes.compact.join(" ")
    end

    def error_class(method)
      object.errors[method].any? ? ERROR_CLASS : ""
    end
  end
end
