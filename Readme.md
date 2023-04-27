# ChatGPT Voice Assistant

Este programa permite interactuar con el modelo de lenguaje ChatGPT de OpenAI mediante voz. El usuario puede hablar al micrófono y recibir respuestas de ChatGPT en formato de audio.

## Preparación

1. Ejecuta `install_python_and_requirements.bat` haciendo doble clic en él. Esto instalará Python (si es necesario) y las dependencias del programa.

2. Modifica el archivo `gpt_config.py` con un editor de texto (por ejemplo, Bloc de notas) y reemplaza los campos "your_username" y "your_password" con tu nombre de usuario (correo electrónico) y contraseña de ChatGPT.

## Ejecución

Ejecuta `run_main.bat` haciendo doble clic en él para iniciar el programa principal. Una vez que el programa esté en ejecución, podrás hablar al micrófono y recibir respuestas de ChatGPT en formato de audio.

## Funcionamiento del programa

El programa realiza las siguientes acciones:

1. Inicia una sesión de navegador y se conecta a ChatGPT.
2. Autentica al usuario utilizando las credenciales proporcionadas en `gpt_config.py`.
3. Permite al usuario grabar su voz para realizar preguntas o enviar mensajes a ChatGPT.
4. Convierte el audio grabado a texto y lo envía a ChatGPT.
5. Recibe la respuesta de ChatGPT en formato de texto.
6. Convierte la respuesta de texto a audio y la reproduce para el usuario.