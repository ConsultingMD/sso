class Hash  
  def try(method, *args, &block)
    keys = [method, method.to_s]
    if keys.any?{|key| key?(method) }
      self[key.first] || self[keys.last]
    else
      super
    end
  end
end