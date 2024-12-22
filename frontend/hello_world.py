import os
from django.http import HttpResponse
from django.urls import path
from django.core.wsgi import get_wsgi_application
from django.core.management import execute_from_command_line

# Minimal settings
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'hello_world')

BASE_DIR = os.path.dirname(os.path.abspath(__file__))

# Django settings
SECRET_KEY = 'fake-key'
DEBUG = True
ROOT_URLCONF = '__main__'

# HTML Template with basic CSS
html_content = """
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hello World</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f8ff;
            text-align: center;
            padding: 50px;
        }
        h1 {
            color: #2c3e50;
            font-size: 48px;
            margin-bottom: 20px;
        }
        p {
            font-size: 18px;
            color: #34495e;
        }
        .button {
            padding: 10px 20px;
            font-size: 16px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
        }
        .button:hover {
            background-color: #2980b9;
        }
    </style>
</head>
<body>
    <h1>Hello, World!</h1>
    <p>Welcome to your first Django page. This page has some basic styling!</p>
    <a href="#" class="button">Learn More</a>
</body>
</html>
"""

# A simple view function
def hello_world(request):
    return HttpResponse(html_content)

# URL patterns
urlpatterns = [
    path('', hello_world),
]

# WSGI application
application = get_wsgi_application()

if __name__ == "__main__":
    execute_from_command_line()
