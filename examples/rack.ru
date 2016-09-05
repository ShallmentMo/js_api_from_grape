require 'grape'
require 'pry'

module Grape
  class API
    class << self
      def generate_js_api
        apis = routes.reduce([]) do |memo, route|
          memo << {
            params: route.params,
            method: route.request_method,
            path: route.path,
          }
        end
        
        get :js_api do
          api_string = <<JS
          var API= {
            apis: JSON.parse('#{apis.to_json}')
          };

          API.fetch = function(method, path, params) {
            const targetAPI = this.apis.find(function (api){
              return method === api.method && (new UrlPattern(api.path).match(path))
            })
            // validate params
            if(targetAPI) {
              return fetch(path, Object(params, { method }));
            }
            return new Promise(function (resolve, rejected) {
              rejected(new Error('can not find API'));
            })
          }
JS
          routes.each do |route|
          end
          content_type 'application/javascript'
          env['api.format'] = :binary
          api_string
        end
      end
    end
  end
end

class API < Grape::API
  version 'v1'
  format :json
  prefix :api

  resources :posts do
    desc 'Return a post.'
    params do
      requires :id, type: Integer, desc: 'Post id.'
    end
    route_param :id do
      get do
        { id: 'id' }
      end
    end
  end

  generate_js_api
end

map '/index' do
  run Proc.new { |env| ['200', {'Content-Type' => 'text/html'}, [<<HTML
<html>
<head>
<script type="text/javascript" src="/js/url-pattern.js"></script>
<script type="text/javascript" src="/api/v1/js_api"></script>
</head>
<body>
test page
<script type="text/javascript">
API.fetch('GET', '/api/v1/posts/123', { page: 123 }).then(function(response){
  console.log(response);
}).catch(function(error) {
  console.log(error.message);
});
</script>
</body>
</html>
HTML
  ]]}
end
use Rack::Static, urls: ['/js']
run API


