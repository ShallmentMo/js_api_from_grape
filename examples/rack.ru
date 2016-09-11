require 'grape'
require 'js_api_from_grape'

class API < Grape::API
  version 'v1'
  format :json
  prefix :api

  resources :posts do
    desc 'Return a post.'
    params do
      requires :id, type: Integer, desc: 'Post id.'
      requires :page, type: Integer
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
run API
