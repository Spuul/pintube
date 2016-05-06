module Request
  module JsonHelpers
    def json_response
      @json_response ||= JSON.parse(response.body, symbolize_names: true)
    end
  end

  module HeadersHelpers
    def api_header(version: 1)
      request.env['HTTP_ACCEPT'] = "application/vnd.pintube.v#{version}"
    end

    def api_response_format(format: Mime::JSON)
      request.env['HTTP_ACCEPT'] = "#{request.env['HTTP_ACCEPT']}, #{format}"
      request.env['CONTENT_TYPE'] = "#{format}"
    end

    def include_default_accept_headers
      api_header
      api_response_format
    end
  end
end
