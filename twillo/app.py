from twilio.rest import Client

# Set up Twilio client with your account SID and auth token
client = Client(account_sid, auth_token)

# Define the text you want to convert to speech
text = "Hello, this is a test message."

# Specify the language and voice you want to use
language = "en-US"
voice = "alice"

# Send the API request to Twilio Voice API
response = client.calls.create(
    twiml='<Say voice="{0}" language="{1}">{2}</Say>'.format(voice, language, text),
    to='+1234567890',
    from_='+9876543210'
)

print(response.sid)
