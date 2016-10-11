if defined? ThinkingSphinx
  class ThinkingSphinx::Configuration
    private

    def settings_file
      framework_root.join 'config', 'SERVICES', Rails.env.to_s, 'thinking_sphinx.yml'
    end
  end
end
