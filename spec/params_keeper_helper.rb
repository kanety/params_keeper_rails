def create_controller(controller_class, url, keep_params = nil)
  controller = controller_class.new
  if keep_params
    controller.class.clear_keep_params!
    controller.class.keep_params(*keep_params)
  end
  request, response = create_request_and_response(url)
  controller.set_request!(request)
  controller.set_response!(response)
  controller
end

def create_request_and_response(url)
  request = ActionDispatch::Request.new(Rack::MockRequest.env_for("http://localhost#{url}"))
  response = ActionDispatch::Response.new
  response.request = request
  [request, response]
end
