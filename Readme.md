ChatGPT Voice Assistant
This program allows you to interact with OpenAI's ChatGPT language model through English voice commands. Users can speak into the microphone and receive audio responses from ChatGPT. The program performs web scraping on https://chat.openai.com/, so it opens a Chrome instance (the user must have Chrome installed, it is not in the requirements.txt file), and the user should leave it open while using the program and follow the instructions in the Command Prompt. For now, it only supports Windows.

Setup
To install the program, there are three files provided in the Setup folder: one for installing Python ("Python Setup.bat"), another for updating pip ("Update PIP.bat"), and another for installing only the required dependencies ("Install Requirements"). It is recommended to have Python and pip working beforehand and install only the requirements. If you don't have Python installed, it is recommended to visit https://www.python.org/downloads/. If you want to use the provided installers, the correct order would be: a. Python Setup.bat b. Update PIP.bat c. Install Requirements.bat

Modify the GPT_config.py file (in the Scripts folder) with a text editor (e.g., Notepad) and replace the fields "your_username" and "your_password" with your ChatGPT username (email address) and password.

Execution
Double-click on Run Voice GPT.bat to launch the main program. Once the program is running, you can speak into the microphone and receive audio responses from ChatGPT by following the Command Prompt and leaving the Chrome window open.

Program Operation
The program performs the following actions:

1. Starts a browser session and connects to ChatGPT.
2. Authenticates the user using the credentials provided in gpt_config.py.
3. Allows the user to record their voice for asking questions or sending messages to ChatGPT in English.
4. Converts the recorded audio to text and sends it to ChatGPT.
5. Receives the response from ChatGPT in text format.
6. Converts the text response to audio and plays it back for the user.


