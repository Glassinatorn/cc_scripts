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

local function test(prompt, api_key)
    -- API endpoint for chat completions
    local endpoint = "https://api.openai.com/v1/chat/completions"

    -- Maximum number of tokens in the generated response
    local maxTokens = 100

    -- Pre-trained model to use for generating responses
    local model = "gpt-3.5-turbo"

    -- Headers for the HTTP request
    local headers = {
        ["Authorization"] = "Bearer " .. api_key,
        ["Content-Type"] = "application/json"
    }

    -- Array to store the conversation messages
    local messages = {}

    -- Start an infinite loop for user input and model responses
    messages = {{
        role = "user",
        content = prompt
    }}

    -- Prepare the payload JSON to send to the API
    local payloadJson = textutils.serializeJSON({
        ["model"] = model,
        ["max_tokens"] = maxTokens,
        ["messages"] = messages
    })

    -- Send the HTTP request to the OpenAI API
    local requesting = true
    http.request(endpoint, payloadJson, headers)

    -- Wait for the HTTP response event
    while requesting do
        local event, url, sourceText = os.pullEvent()

        -- Handle successful HTTP response
        if event == "http_success" then
            local responseBody = sourceText.readAll()
            sourceText.close()
            local responseJson = textutils.unserializeJSON(responseBody)

            -- Check if a valid response was received
            if responseJson and responseJson.choices and responseJson.choices[1] then
                local generatedText = responseJson.choices[1].message.content

                -- Add the model's generated response to the conversation messages array
                table.insert(messages, {
                    role = "system",
                    content = generatedText
                })

                -- Print the generated response from the model
                print("[GPT]: ")
                print(generatedText)
            else
                print("Error: Failed to get a valid response.")
            end
            requesting = false

            -- Handle failed HTTP response
        elseif event == "http_failure" then
            print("Server didn't respond.")
            requesting = false
        end
    end
end

return {
    gatherResponse = gatherResponse,
    get_page = get_page,
    test = test
}
