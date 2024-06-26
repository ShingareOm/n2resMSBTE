#!/bin/bash

TOKEN="YOUR-AUTH-TOKEN"
CHAT_ID="YOUR-CHAT-ID"
URL="WESITE"
SEARCH_TEXT="KEYWORD-TO-SEARCH"
#FOR LINUX
TEMP_FILE="/tmp/website_content.txt"

send_telegram_message() {
    local message="$1"
    curl -s -X POST "https://api.telegram.org/bot$TOKEN/sendMessage" \
        -d chat_id="$CHAT_ID" \
        -d text="$message" \
        -d parse_mode="HTML" > /dev/null
}

curl -s "$URL" > "$TEMP_FILE"

if grep -q "$SEARCH_TEXT" "$TEMP_FILE"; then
    DATE="$(date +'%d.%b.%Y -- %H:%M')"
    MESSAGE="<b>Bro</b>, Your result is out : <b>$DATE</b>"
    send_telegram_message "$MESSAGE"
fi
rm "$TEMP_FILE"
exit 0
