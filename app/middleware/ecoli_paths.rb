class EcoliPaths
  
  def initialize(app)
    @app = app
  end

  def call(env)
    
    # env will be rewritten in place by calls to request (FYI)
    request = Rack::Request.new(env)
    
    # Split /product/colorId/123/productId/456 into product and an array of the rest
    resource, *param_array = request.path_info[1..-1].split('/')
    
    # Populate parameters
    param_obj = request.get? ? request.GET : request.POST    
    param_array.each_slice(2) do |key,value|
      param_obj[key] = value
    end
    
    # Rewrite path.. probably not needed, but you could have a resource like..
    # [controller].[method].[format] if you wanted to and then rewrite to /[controller]/[method].[format]
    request.path_info = "/#{resource}"
    
    # Now call the app with our rewritten request
    @app.call( env )
  end
  
end