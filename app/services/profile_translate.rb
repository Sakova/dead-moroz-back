class ProfileTranslate
  def self.translate(array)
    request, http = ApiRequest.call(API_TRANSLATE_PATH, TRANSLATE_HOST).values_at(:request, :http)

    array.map do |item|
      request.body = "{
          #{"q".dump}: \"#{item}\",
          \"source\": \"en\",
          \"target\": \"fi\"
      }"

      response = http.request(request)
      JSON.parse(response.read_body)["data"]["translations"]["translatedText"]
    end
  end
end
