import openai
import sys

openai.api_key = sys.argv[1]
prompt = sys.argv[2:]
messages = [ {"role": "system", "content": prompt} ]

chat = openai.ChatCompletion.create( 
    model = "gpt-3.5-turbo", messages = messages
)

reply = chat.choices[0].message.content

print(reply)
