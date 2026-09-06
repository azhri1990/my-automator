#!/bin/bash
API_KEY="sk-infr-8la1zjzz.60uqyxbskno8cvj3y4dnu3t2xr1y2u1v"
BASE_URL="https://api.infr.ad/v1"

echo "Testing deepseek-v4-flash..."
curl -s -X POST $BASE_URL/chat/completions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $API_KEY" \
  -d '{"model":"deepseek-v4-flash","messages":[{"role":"user","content":"Hello, say hello back"}]}' | jq -r '.choices[0].message.content'

echo "Testing hy3..."
curl -s -X POST $BASE_URL/chat/completions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $API_KEY" \
  -d '{"model":"hy3","messages":[{"role":"user","content":"Hello, say hello back"}]}' | jq -r '.choices[0].message.content'

echo "Testing gpt-5.6-luna..."
curl -s -X POST $BASE_URL/chat/completions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $API_KEY" \
  -d '{"model":"gpt-5.6-luna","messages":[{"role":"user","content":"Hello, say hello back"}]}' | jq -r '.choices[0].message.content'
