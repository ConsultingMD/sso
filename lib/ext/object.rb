class Object
  def attempt(method, *args, &block)
    if present? && respond_to?(method)
      send(method, *args, &block)
    end
  end
end