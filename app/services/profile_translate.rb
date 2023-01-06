class ProfileTranslate
  def self.translate(text)
    request, http = ApiRequest.call(API_TRANSLATE_PATH, TRANSLATE_HOST).values_at(:request, :http)

    request.body = "{
        #{"q".dump}: \"#{text}\",
        \"source\": \"en\",
        \"target\": \"fi\"
    }"

    response = http.request(request)
    JSON.parse(response.read_body)["data"]["translations"]["translatedText"].split("___")
  end
end
