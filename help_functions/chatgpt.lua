function gatherResponse(prompt, api_key)
    -- prepare the request
    local url = "https://api.openai.com/v1/moderations"
    local request = '{"input" : "' .. prompt .. '"}'

    local headers = {
        ["Content-Type"] = "application/json",
        ["Authorization"] = "Bearer " .. api_key
    }

    local response = http.post(url, request, headers)

    if response == nil then
        error("Failed to make request to OpenAI API")

        return nil
    else
        local responseBody = response.readAll()
        response.close()

        local parsedResponse = http.jsonParse(responseBody)
        local generatedText = parsedResponse.choices[1].text

        return generatedText
    end
end

return { gatherResponse = gatherResponse }
