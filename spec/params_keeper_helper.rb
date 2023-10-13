def create_controller(controller_class, url, keep_params = nil)
  controller = controller_class.new
  if keep_params
    controller.class.clear_keep_params!
    controller.class.keep_params(*keep_params)
  end
  controller.set_request! ActionDispatch::Request.new(Rack::MockRequest.env_for("http://localhost#{url}"))
  controller.set_response! ActionDispatch::Response.new
  controller
end
