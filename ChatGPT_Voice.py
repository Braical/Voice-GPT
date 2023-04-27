from selenium.webdriver.common.by import By
from selenium.webdriver.support.wait import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.common.exceptions import StaleElementReferenceException
import time
import undetected_chromedriver as uc
import speech_recognition as sr
import pyaudio
import wave 
from gtts import gTTS
import gpt_config
import pyperclip
import pygame
import threading
import sys
import os
os.environ['PYGAME_HIDE_SUPPORT_PROMPT'] = '1'
import pygame

# Modificamos una clase en Undetected Chromedriver para que no se cierre el chrome al terminar el programa
class My_Chrome(uc.Chrome):
    def __del__(self):
        pass

website = 'https://chat.openai.com'
options = uc.ChromeOptions() 
options.add_argument("--password-store=basic")
options.add_experimental_option(
    "prefs",
    {
        "credentials_enable_service": False,
        "profile.password_manager_enabled": False,
    },
)

# Abrir Navegador
driver = My_Chrome(options=options)
driver.get(website)
driver.set_window_position(950, 0)
driver.set_window_size(400, 300)
username = gpt_config.username
password = gpt_config.password

def text_to_speech(text):
    tts = gTTS(text=text, lang="en")
    temp_filename = "C:/Users/Brian/OneDrive/Documentos/Python/BOT_GPT/Audio/temp_response.mp3"
    tts.save(temp_filename)
    play_audio(temp_filename)

def speech_to_text(filename):
    recognizer = sr.Recognizer()
    with sr.AudioFile(filename) as source:
        audio = recognizer.record(source)
    return recognizer.recognize_google(audio, language="en-US")

def play_audio(filename):
    pygame.mixer.init()
    pygame.mixer.music.load(filename)
    pygame.mixer.music.play()
    while pygame.mixer.music.get_busy():
        pygame.time.Clock().tick(10)
    pygame.mixer.quit()

def record_audio(filename, duration=10):
    FORMAT = pyaudio.paInt16
    CHANNELS = 1
    RATE = 16000
    CHUNK = 1024

    audio = pyaudio.PyAudio()

    print("Grabando...")
    stream = audio.open(format=FORMAT, channels=CHANNELS, rate=RATE, input=True, frames_per_buffer=CHUNK)
    frames = []

    for _ in range(0, int(RATE / CHUNK * duration)):
        data = stream.read(CHUNK)
        frames.append(data)

    print("Grabación finalizada")

    stream.stop_stream()
    stream.close()
    audio.terminate()

    with open(filename, 'wb') as f:
        wav_file = wave.open(f, 'wb')
        wav_file.setnchannels(CHANNELS)
        wav_file.setsampwidth(audio.get_sample_size(FORMAT))
        wav_file.setframerate(RATE)
        wav_file.writeframes(b''.join(frames))
        wav_file.close()

def wait_for_input():
    input("Presione una tecla para continuar...")

def solicitud():
    # Ingreso del mensaje, solicita al usuario que hable y lo graba en un archivo
    print("Send a Message")
    audio_filename = "C:/Users/Brian/OneDrive/Documentos/Python/BOT_GPT/Audio/temp_input.wav"
    user_text = False
    recognized = False
    attempts = 0
    while not recognized and attempts < 3:
        record_audio(audio_filename)
        try:
            user_text = speech_to_text(audio_filename)
            print(user_text)
            recognized = True
        except sr.UnknownValueError as e:
            print("No se reconoce solicitud, inténtalo de nuevo.")
            print(f"Error: {e}")
            attempts += 1

    # Le escribe el audio transformado a texto a ChatGPT -\n es un enter-
    if user_text:
        driver.find_element(By.XPATH,'//textarea').send_keys(user_text)
        time.sleep(1)
        WebDriverWait(driver, timeout=3).until(EC.element_to_be_clickable((By.XPATH,'//button[contains(@class,"absolute")]')))
        driver.find_element(By.XPATH,'//button[contains(@class,"absolute")]').click()
    else:
        user_text = False

    return user_text

def respuesta():
    # Lee el texto devuelto por ChatGPT (Apreta el botón clipboard)
    try:
        WebDriverWait(driver, timeout=15).until(EC.presence_of_element_located((By.XPATH,f'(//button[contains(@class,"flex ml-auto")])[{button_index}]')))
        WebDriverWait(driver, timeout=15).until(EC.element_to_be_clickable((By.XPATH,f'(//button[contains(@class,"flex ml-auto")])[{button_index}]')))
        for _ in range(3):  # Intenta hasta 3 veces
            try:
                driver.find_element(By.XPATH,f'(//button[contains(@class,"flex ml-auto")])[{button_index}]').click()
                break
            except StaleElementReferenceException:
                pass
        else:
            raise Exception("No se pudo hacer clic en el botón después de 3 intentos")
        
        time.sleep(1)
        response = pyperclip.paste()
    except Exception as e:
        print("Error:", e)
        response = 0
    # Convertimos la respuesta de ChatGPT en voz (Y la imprimimos para verificar)
    if response:
        print(response)
        text_to_speech(response)
        time.sleep(2)
    else:
        print("No hay texto para reproducir.")
    return response

# Loguearse
WebDriverWait(driver, timeout=10).until(EC.presence_of_element_located((By.XPATH, '//button[contains(div/text(), "Log in")]')))
driver.find_element(By.XPATH,'//button[contains(div/text(), "Log in")]').click()

# Usuario (Mail)
WebDriverWait(driver, timeout=3).until(EC.presence_of_element_located((By.ID,'username')))
driver.find_element(By.ID,'username').send_keys(username)
driver.find_element(By.XPATH,'//button[contains(@name,"action")]').click()

# Password 
WebDriverWait(driver, timeout=3).until(EC.presence_of_element_located((By.ID,'password')))
driver.find_element(By.ID,'password').send_keys(password)
driver.find_element(By.XPATH,'//button[contains(@name,"action")]').click()

# Cartel Welcome
WebDriverWait(driver, timeout=10).until(EC.presence_of_element_located((By.XPATH,'//button[contains(div/text(), "Next")]')))
driver.find_element(By.XPATH,'//button[contains(div/text(), "Next")]').click()

# Cartel Next
WebDriverWait(driver, timeout=3).until(EC.presence_of_element_located((By.XPATH,'//button[contains(div/text(), "Next")]')))
driver.find_element(By.XPATH,'//button[contains(div/text(), "Next")]').click()

# Cartel "Done"
WebDriverWait(driver, timeout=3).until(EC.presence_of_element_located((By.XPATH,'//button[contains(div/text(), "Done")]')))
driver.find_element(By.XPATH,'//button[contains(div/text(), "Done")]').click()

button_index = 1

while True:
    try:
        message = solicitud()
        if not message:
            print("No se pudo reconocer ningún mensaje después de 3 intentos. Saliendo del programa.")
            break
        response = respuesta()
        if not response:
            print("No se recibió ninguna respuesta. Saliendo del programa.")
            break

        # Incrementamos el índice del botón en 1 para la próxima iteración
        button_index += 1

    except Exception as e:
        print("Error:", e)
        break