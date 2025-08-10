import datetime
import os.path
from collections import defaultdict

from google.auth.transport.requests import Request
from google.oauth2.credentials import Credentials
from google_auth_oauthlib.flow import InstalledAppFlow
from googleapiclient.discovery import build
from googleapiclient.errors import HttpError

import json

# If modifying these scopes, delete the file token.json.
SCOPES = ["https://www.googleapis.com/auth/calendar.readonly"]
BASE_PATH = "/home/volty/.google"
TOKEN_PATH = BASE_PATH + "/" + "token.json"
CREDENTIALS_PATH = BASE_PATH + "/" + "credentials.json"
CALENDAR_CONFIG_PATH = BASE_PATH + "/" + "calendar.json"


def main():
    """Shows basic usage of the Google Calendar API.
    Prints the start and name of the next 10 events from configured calendars.
    """
    # Load calendar configuration
    if not os.path.exists(CALENDAR_CONFIG_PATH):
        print(f"Calendar config file not found: {CALENDAR_CONFIG_PATH}")
        print("Please create a calendar.json file with your calendar mappings.")
        return

    try:
        with open(CALENDAR_CONFIG_PATH, "r") as f:
            config = json.load(f)
            calendar_mappings = config.get("calendars", {})
    except json.JSONDecodeError as e:
        print(f"Error reading calendar config: {e}")
        return
    except Exception as e:
        print(f"Error loading calendar config: {e}")
        return

    if not calendar_mappings:
        print("No calendars configured in calendar.json")
        return
    creds = None
    # The file token.json stores the user's access and refresh tokens, and is
    # created automatically when the authorization flow completes for the first
    # time.
    if os.path.exists(TOKEN_PATH):
        creds = Credentials.from_authorized_user_file(TOKEN_PATH, SCOPES)
    # If there are no (valid) credentials available, let the user log in.
    if not creds or not creds.valid:
        if creds and creds.expired and creds.refresh_token:
            creds.refresh(Request())
        else:
            flow = InstalledAppFlow.from_client_secrets_file(CREDENTIALS_PATH, SCOPES)
            creds = flow.run_local_server(port=0)
        # Save the credentials for the next run
        with open(TOKEN_PATH, "w") as token:
            token.write(creds.to_json())

    try:
        service = build("calendar", "v3", credentials=creds)

        # Get current time
        now = datetime.datetime.now(tz=datetime.timezone.utc).isoformat()

        # Collect events from configured calendars
        all_events = []

        for calendar_name, calendar_id in calendar_mappings.items():

            try:
                # Call the Calendar API for each calendar
                events_result = (
                    service.events()
                    .list(
                        calendarId=calendar_id,
                        timeMin=now,
                        maxResults=10,  # Get up to 10 from each calendar
                        singleEvents=True,
                        orderBy="startTime",
                    )
                    .execute()
                )
                events = events_result.get("items", [])

                # Add calendar info to each event
                for event in events:
                    event["calendar_name"] = calendar_name
                    event["calendar_id"] = calendar_id
                    all_events.append(event)

            except HttpError as error:
                print(f"Error accessing calendar '{calendar_name}': {error}")
                continue

        if not all_events:
            print("No upcoming events found in any calendar.")
            return

        # Sort all events by start time
        all_events.sort(
            key=lambda x: x["start"].get("dateTime", x["start"].get("date"))
        )

        # Take only the first 10 events overall
        upcoming_events = all_events[:15][::-1]
        for event in upcoming_events:
            start = event["start"].get("dateTime", event["start"].get("date"))
            calendar_name = event["calendar_name"]
            event_title = event["summary"]

            # Format datetime for better readability
            if "T" in start:  # datetime format
                dt = datetime.datetime.fromisoformat(start.replace("Z", "+00:00"))
                formatted_time = dt.strftime("%Y-%m-%d %H:%M")
            else:  # date format
                formatted_time = f"{start}      "

            print(f"{formatted_time} | [{calendar_name[0]}] {event_title}")

    except HttpError as error:
        print(f"An error occurred: {error}")


if __name__ == "__main__":
    main()
