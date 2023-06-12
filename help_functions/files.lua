function readApiKeyFromFile(filePath)
  local file = io.open(filePath, "r") -- Open the file in read mode
  if file then
    local apiKey = file:read("*l") -- Read the first line (assuming the API key is stored on a single line)
    file:close() -- Close the file
    return apiKey
  end
  return nil -- File not found or error occurred
end

return { read_api_key = read_api_key }
