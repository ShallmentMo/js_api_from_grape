require 'js_api_from_grape/version'

module JsApiFromGrape
  def self.url_pattern_code
    File.read('../vender/js/url-pattern.js')
  end
end

module Grape
  class API
    class << self
      def generate_js_api
        apis = routes.reduce([]) do |memo, route|
          memo << {
            params: route.params,
            method: route.request_method,
            path: route.path
          }
        end

        get :js_api do
          api_string = <<JS
          #{JsApiFromGrape.url_pattern_code}

          var API= {
            apis: JSON.parse('#{apis.to_json}')
          };

          API.utils = {
            combineGetParamsToPath: function(path, params) {
              return `${path}?${Object.keys(params).map(key => { return `${key}=${params[key]}`}).join('&')}`;
            }
          }

          API.fetch = function(method, path, params={}) {
            const targetAPI = this.apis.find(function (api){
              return method === api.method && (new UrlPattern(api.path).match(path))
            })
            // get the params from path
            Object.assign(params, new UrlPattern(targetAPI.path).match(path))

            if(targetAPI) {
              // validate params
              var error = null;
              Object.keys(targetAPI.params).forEach(key => {
                if(targetAPI.params[key].required && (params[key] === null || params[key] === undefined || params[key] === '')) {
                  error = new Error(`${key} is required`);
                }
              })

              if (error) {
                return new Promise(function (resolve, rejected){
                  rejected(error);
                })
              }

              if (method == 'GET') {
                return fetch(API.utils.combineGetParamsToPath(path, params));
              }
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
