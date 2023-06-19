import openai
import sys
import os
import time

def chatgpt_response(prompt, api_key):
    openai.api_key = api_key
    messages = [ {"role": "system", "content": "this is a test"} ]

    chat = openai.ChatCompletion.create( 
        model = "gpt-3.5-turbo", messages = messages
    )

    reply = chat.choices[0].message.content

    return reply

def save_to_file(reply):
    f = open("reply.txt", "w")
    print(f'writing reply.txt')
    f.write(reply)
    f.close()


if __name__ == "__main__":
    prompt = sys.argv[1:]
    api_key = open("openai.key", "r").read()
    api_key = api_key.replace('\n', '')
    print(f'prompt: {prompt}')

    reply = chatgpt_response(prompt, api_key)

    save_to_file(reply)
