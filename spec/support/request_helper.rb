def request(session_vars={})
  ActionDispatch::TestRequest.create(
    'rack.session' => OpenStruct.new(session_vars)
  )
end
