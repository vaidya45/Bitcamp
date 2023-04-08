from twilio.rest import Client
import os
from dotenv import load_dotenv

# Set up Twilio client with your account SID and auth token

# Load environment variables from .env file
load_dotenv()

# Access environment variables
account_sid = os.getenv("TWILIO_ACCOUNT_SID")
auth_token = os.getenv("TWILIO_AUTH_TOKEN")

client = Client(account_sid, auth_token)

# Define the text you want to convert to speech
text = "Hello, this is a test message."

# Specify the language and voice you want to use
language = "en-US"
voice = "alice"

# Send the API request to Twilio Voice API
response = client.calls.create(
    twiml='<Say voice="{0}" language="{1}">{2}</Say>'.format(
        voice, language, text),
    to='+1234567890',
    from_='+9876543210'
)

print(response.sid)
