require "rack"
require ::File.expand_path("../../config/environment", __FILE__)

module Builders
  UI_ROOT = "agile-direction-ui/dist".freeze

  API = Rack::Builder.new do
    use Rack::Cors do
      allow do
        origins(ENV["UI_HOST"])
        resource("*", { headers: :any, methods: :get })
      end
    end

    run(Rails.application)
  end

  UI = Rack::Builder.new do
    use(Rack::Static, {
      urls: %w(/assets),
      root: UI_ROOT
    })

    run(lambda do |env|
      if env["PATH_INFO"].match(%r{^/api})
        [404, {}, ["Not Found in UI"]]
      else
        ui_index = File.open("#{UI_ROOT}/index.html", File::RDONLY)
        [200, {}, ui_index]
      end
    end)
  end

  FULL_STACK = Rack::Cascade.new([UI, API])
end
