class Feature < ActiveRecord::Base
  FEATURES = {
    search: false
  }

  class << self
    FEATURES.each do |key, _|
      define_method("#{key}_enabled?") do
        Feature.find_by_key(key).enabled
      end
    end

    def reload_features!
      FEATURES.each do |key, value|
        self.create_with(key: key, enabled: value).find_or_create_by(key: key)
      end
    end

    def enable!(key)
      if FEATURES.has_key?(key.to_sym)
        Feature.find_by_key(key).update_attributes(enabled: true)
      end
    end

    def disable!(key)
      if FEATURES.has_key?(key.to_sym)
        Feature.find_by_key(key).update_attributes(enabled: false)
      end
    end
  end

  reload_features!
end
