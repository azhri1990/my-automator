import openai

# Set the API key and base URL for the older library
openai.api_key = "sk-infr-8la1zjzz.60uqyxbskno8cvj3y4dnu3t2xr1y2u1v"
openai.api_base = "https://api.infr.ad/v1"

try:
    response = openai.ChatCompletion.create(
        model="deepseek-v4-flash",
        messages=[{"role": "user", "content": "Explain SSE in one paragraph"}],
    )
    print("✅ Success!")
    print(response.choices[0].message.content)
except Exception as e:
    print(f"❌ Error: {e}")
