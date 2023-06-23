local function gather_response(prompt, api_key)
    local endpoint = "https://api.openai.com/v1/chat/completions"

    local headers = {
        ["Authorization"] = "Bearer " .. api_key,
        ["Content-Type"] = "application/json"
    }

    local payloadJson = textutils.serializeJSON({
        ["model"] = "gpt-3.5-turbo",
        ["max_tokens"] = 100,
        ["messages"] = {{
                role = "user",
                content = prompt
            }},
    })

    -- Send the HTTP request to the OpenAI API
    local requesting = true
    http.request(endpoint, payloadJson, headers)

    -- Wait for HTTP response 
    while requesting do
        local event, url, sourceText = os.pullEvent()

        -- Handle successful HTTP response
        if event == "http_success" then
            local responseBody = sourceText.readAll()
            sourceText.close()
            local responseJson = textutils.unserializeJSON(responseBody)

            -- Check if a valid response was received
            if responseJson and responseJson.choices and responseJson.choices[1] then
                local reply = responseJson.choices[1].message.content

                -- Print the generated response from the model
                print("Response: " .. reply)
                return reply
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

return { gather_response = gather_response }
