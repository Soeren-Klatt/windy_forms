# frozen_string_literal: true

module WindyForms
  class Engine < ::Rails::Engine
    initializer "windy_forms.helper" do
      ActiveSupport.on_load(:action_view) do
        include WindyForms::Helper
      end
    end
  end
end
