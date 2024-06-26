[![GitHub stars](https://img.shields.io/github/stars/ShingareOm/n2resMSBTE?style=flat-square)](https://github.com/ShingareOm/n2resMSBTE/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/ShingareOm/n2resMSBTE?style=flat-square)](https://github.com/ShingareOm/n2resMSBTE/network)
[![GitHub issues](https://img.shields.io/github/issues/ShingareOm/n2resMSBTE?style=flat-square)](https://github.com/ShingareOm/n2resMSBTE/issues)
[![GitHub license](https://img.shields.io/github/license/ShingareOm/n2resMSBTE?style=flat-square)](https://github.com/ShingareOm/n2resMSBTE/blob/main/LICENSE)

## Automating Result Notifications with Cron and Curl By Om Shingare

### Result Notifier
![Workflow](/banner.png)

### Table of Contents
1. [Workflow Diagram](#workflow-diagram)
2. [What is Curl?](#what-is-curl)
3. [What are Cron Jobs?](#what-are-cron-jobs)
4. [Shell Script Code](#shell-script-code)
5. [Setting Up Cron Job in Linux ECS Server](#setting-up-cron-job-in-linux-ecs-server)
6. [For Android: Using Third-Party Tools](#for-android-using-third-party-tools)

---

### Workflow Diagram
![Workflow](/workflow.png)

### What is Curl?
Curl is a command-line tool used to transfer data to or from a server, using various protocols like HTTP, HTTPS, FTP, etc. Its purpose in this project is to fetch the HTML content from a specific URL (the result page of an institution's website). This fetched HTML is then saved to a file (result.html), where the script checks for specific text ("Select Enrollment No."). If found, it triggers a notification via the Telegram bot API, informing about the availability of exam results. Thus, curl is integral for automating the retrieval of web content, crucial for monitoring updates like result declarations.

### What are Cron Jobs?
Cron is a time-based job scheduler in Unix-like operating systems. Its purpose in this project is to execute a shell script (check_result.sh, for example) at regular intervals (every minute in this case). This shell script uses tools like curl to fetch the HTML content from a specified URL (e.g., the result page of an institution's website). By scheduling this script with cron, the project automates the periodic checking of the website for result updates. If specific conditions are met (e.g., finding "Select Enrollment No." in the fetched HTML), the script can trigger actions like sending notifications via the Telegram bot API. Therefore, cron enables the automation of repetitive tasks, crucial for timely updates and notifications in projects like this result alert system.

### Shell Script Code
```bash
#!/bin/bash

TOKEN="YOUR-AUTH-TOKEN"
CHAT_ID="YOUR-CHAT-ID"
URL="https://msbte.org.in/pcwebBTRes/pcResult01/pcfrmViewMSBTEResult.aspx"
SEARCH_TEXT="Select Enrollment No"
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
    MESSAGE="<b>Bro</b>, your MSBTE Result is out at : <b>$DATE</b>"
    send_telegram_message "$MESSAGE"
fi
rm "$TEMP_FILE"
exit 0
```

### Setting Up Cron Job in Linux ECS Server
Ensure your cron job is set to run check_result.sh every minute. Edit your crontab (`crontab -e`) and add the following line:
```bash
* * * * * /bin/bash /path/to/check_result.sh
```

### Explanation of Each Part:
- **Shebang (`#!/bin/bash`)**: Indicates that the script should be executed using the Bash shell.
- **Telegram Bot Credentials**: Replace "YOUR-AUTH-TOKEN" and "YOUR-CHAT-ID" with your actual bot token and chat ID.
- **URL**: The website page from which you want to fetch content.
- **Search Text**: The text pattern that the script will search for within the fetched content.
- **Temporary File**: Path to a temporary file where the script will save the fetched website content.
- **Function `send_telegram_message()`**: Sends messages via the Telegram bot API.
- **Main Script Execution**: Fetches website content, checks for the search text, and sends a notification if the text is found.
- **Cleanup**: Removes the temporary file after processing.
- **Exit Status**: Exits the script with status 0, indicating successful execution.

### Functionality:
- **Purpose**: Automates checking a webpage for specific text indicating exam results.
- **Notification**: Sends a Telegram notification if the text is found.
- **Automation**: Designed to be run periodically to monitor the webpage and alert you when results are published.
- **Customization**: Customize the search text, URL, and message format as needed.

### For Android: Using Third-Party Tools
You can use tools like Uptime Robot to monitor the webpage and send notifications to your Android device. Here's a video demonstrating how to set up the monitor:

[![Uptime Robot Tutorial](/banner.png)](https://github.com/ShingareOm/n2resMSBTE/assets/109802903/bb524b53-aa9e-452d-982a-6fe2a990ec21)

Website: [Uptime Robot](https://uptimerobot.com), After that you can simply login into the android application for update.

<ul>
<li><strong><a href="https://itunes.apple.com/us/app/uptime-robot-app/id1104878581">for iPhone</a></strong></li>
<li><strong><a href="https://play.google.com/store/apps/details?id=com.uptimerobot">for Android</a></strong></li>
</ul>

Author: Om Shingare (<a href="https://in.linkedin.com/in/shingareom">Om Shingare</a>)
