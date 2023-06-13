function gatherResponse(prompt, api_key)
  -- Encode the prompt for HTTP request
  local encodedPrompt = http.encodeURIComponent(prompt)

  -- Make a GET request to the OpenAI API
  local url = "https://api.openai.com/v1/engines/davinci-codex/completions?prompt=" .. encodedPrompt
  local headers = {
    ["Content-Type"] = "application/json",
    ["Authorization"] = "Bearer " .. api_key -- Replace with your OpenAI API key
  }

  local response = http.get(url, headers)
  local responseBody = response.readAll()
  response.close()

  -- Parse the response body and extract the generated text
  local parsedResponse = http.jsonParse(responseBody)
  local generatedText = parsedResponse.choices[1].text

  -- Return the generated text
  return generatedText
end

return { gatherResponse = gatherResponse }
