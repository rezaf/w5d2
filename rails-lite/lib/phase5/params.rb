require 'uri'

module Phase5
  class Params
    # use your initialize to merge params from
    # 1. query string
    # 2. post body
    # 3. route params
    #
    # You haven't done routing yet; but assume route params will be
    # passed in as a hash to `Params.new` as below:
    def initialize(req, res = nil, route_params = {})
      @params = {req: req.query_string, res: res, route_params: route_params}
    end

    def [](key)
      parse_www_encoded_form(@params[:req])[key]
    end

    def to_s
      @params.to_json.to_s
    end

    class AttributeNotFoundError < ArgumentError; end;

    private
    # this should return deeply nested hash
    # argument format
    # user[address][street]=main&user[address][zip]=89436
    # should return
    # { "user" => { "address" => { "street" => "main", "zip" => "89436" } } }
    def parse_www_encoded_form(www_encoded_form)
      converted = URI::decode_www_form(www_encoded_form).to_h
      parse_key(converted)
      # if converted.include?("[")
#         parse_www_encoded_form(converted)
#       end
    end

    # this should return an array
    # user[address][street] should return ['user', 'address', 'street']
    def parse_key(key)
      p key
      key.split(/\]\[|\[|\]/)
    end
  end
end
