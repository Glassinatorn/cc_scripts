import openai
import sys
import os
import time

def check_file():
    try:
        f = open("prompt.txt", "r")
        prompt = f.read()
        os.remove("prompt.txt")

        return prompt
    except:
        print("openai_key.txt not found. Please create one and put your OpenAI API key inside.")
        exit()

def chatgpt_response(prompt, api_key):
    openai.api_key = api_key
    messages = [ {"role": "system", "content": prompt} ]

    chat = openai.ChatCompletion.create( 
        model = "gpt-3.5-turbo", messages = messages
    )

    reply = chat.choices[0].message.content

    return reply

def save_to_file(reply):
    f = open("reply.txt", "w")
    f.write(reply)
    f.close()


if __name__ == "__main__":
    prompt = ""

    while True:
        while prompt == "":
            prompt = check_file()
            time.sleep(1)

        api_key = sys.argv[1]
        reply = chatgpt_response(prompt, api_key)

        save_to_file(reply)
