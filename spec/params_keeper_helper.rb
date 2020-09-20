def create_controller(controller_class, url, keep_params = nil)
  controller = controller_class.new
  if keep_params
    controller.class.clear_keep_params!
    controller.class.keep_params(*keep_params)
  end
  controller.request = ActionDispatch::Request.new(Rack::MockRequest.env_for("http://localhost#{url}"))
  controller.response = ActionDispatch::Response.new
  controller
end
