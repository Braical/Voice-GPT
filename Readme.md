# ChatGPT Voice Assistant

Este programa permite interactuar con el modelo de lenguaje ChatGPT de OpenAI mediante voz. El usuario puede hablar al micrófono y recibir respuestas de ChatGPT en formato de audio.
El programa hace webscraping del sitio https://chat.openai.com/, por lo que abre una instancia de Chrome (El usuario debe tenerlo instalado, no está en el archivo requeriments.txt), dejar abierta mientras se usa.
Por ahora, solamente soporta Windows.

## Preparación

1. Para instalar el programa, se proporcionan 3 archivos, uno para instalar Python ("Install Python.bat"), otro para actualizar pip ("Update PIP.bat"), y otro para instalar sólo las dependencias requeridas por el programa ("Install Requirements"). 
Se recomienda tener instalado python y pip funcionando previamente e instalar sólo los requerimientos.
En caso de no tener instalado Python, el orden correcto sería:
a. Install Python.bat
b. Update PIP.bat
c. Install Requirements.bat


2. Modifica el archivo `GPT_config.py` con un editor de texto (por ejemplo, Bloc de notas) y reemplaza los campos "your_username" y "your_password" con tu nombre de usuario (correo electrónico) y contraseña de ChatGPT.

## Ejecución

Ejecuta `Run Voice GPT.bat` haciendo doble clic en él para iniciar el programa principal. Una vez que el programa esté en ejecución, podrás hablar al micrófono y recibir respuestas de ChatGPT en formato de audio.

## Funcionamiento del programa

El programa realiza las siguientes acciones:

1. Inicia una sesión de navegador y se conecta a ChatGPT.
2. Autentica al usuario utilizando las credenciales proporcionadas en `gpt_config.py`.
3. Permite al usuario grabar su voz para realizar preguntas o enviar mensajes a ChatGPT.
4. Convierte el audio grabado a texto y lo envía a ChatGPT.
5. Recibe la respuesta de ChatGPT en formato de texto.
6. Convierte la respuesta de texto a audio y la reproduce para el usuario.
