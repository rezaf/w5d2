require 'json'
require 'webrick'

module Phase4
  class Session
    # find the cookie for this app
    # deserialize the cookie into a hash
    def initialize(req)
      @session = Hash.new
      req.cookies.each do |cookie|
        if cookie.name.to_s == "_rails_lite_app"
          @session = JSON.parse(cookie.value)
        end
      end
    end

    def [](key)
      @session[key]
    end

    def []=(key, val)
      @session[key] = val
    end

    # serialize the hash into json and save in a cookie
    # add to the responses cookies
    def store_session(res)
      new_cookie = WEBrick::Cookie.new('_rails_lite_app', @session.to_json)
      res.cookies << new_cookie
    end
  end
end
