require 'rack/time_zone_header/version'
require 'tzinfo'

# Code to parse headers in this format:
# http://tools.ietf.org/html/draft-sharhalakis-httptz-05

module Rack
  class TimeZoneHeader
    def initialize(app)
      @app = app
    end

    def call(env)
      header = env["HTTP_TIME_ZONE"] || env["HTTP_X_TIME_ZONE"] || env["HTTP_TIMEZONE"]
      zone = TZInfo::Timezone.get(header.split(";").last) rescue nil
      env["time.zone"] = zone if zone
      @app.call(env)
    end
  end
end
