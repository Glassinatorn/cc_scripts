local function get_page(url) local example = http.get(url)
    local content = example.readAll()
    example.close()

    return content
end
    
function gatherResponse(prompt, api_key)
    -- prepare the request
    local url = "https://api.openai.com/v1/chat/completions"
    local max_tokens = 150
    local model = "gpt3-3.5-turbo"
    local headers = {
        ["Content-Type"] = "application/json",
        ["Authorization"] = "Bearer " .. api_key
    }
    local request = {
        ["model"] = model,
        ["max_tokens"] = max_tokens, 
        ["messages"] = {
            role = "user",
            content = prompt
        }
    }
    local payload_enc = textutils.serializeJSON(request)

    local requesting = true
    http.request(url, payload_enc, headers)

    while requesting do
        local event, url, sourceText = os.pullEvent()

        if event == "http_success" then
            local response = sourceText.readAll()
            sourceText.close()
            local response_json = textutils.unserializeJSON(response)

            if response_json and response_json.choices and response_json.choices[1] then
                local generatedText = response_json.choices[1].text
                return generatedText
            else
                error("Failed to make request to OpenAI API")
            end
            requesting = false

        elseif event == "http_failure" then
            print("Failed to make request to OpenAI API")
            requesting = false
        end

    --local response = http.post(url, request, headers)

    --if response == nil then
        --error("Failed to make request to OpenAI API")

        --return nil
    --else
        --local responseBody = response.readAll()
        --response.close()

        --local parsedResponse = http.jsonParse(responseBody)
        --local generatedText = parsedResponse.choices[1].text

        --return generatedText
    end
end

return { gatherResponse = gatherResponse, get_page = get_page }
