@echo off
echo =========================================================================
echo  Starting Dog Emotion and Distress Detection System (Windows Local)
echo =========================================================================

IF NOT EXIST venv (
    echo [1/4] Creating virtual environment...
    python -m venv venv
)

echo [2/4] Activating environment and installing dependencies...
call venv\Scripts\activate
pip install -r requirements.txt

echo [3/4] Initializing database and generating demo model...
python training/create_demo_model.py
python scripts/initialize_database.py

echo [4/4] Starting Flask backend and Frontend web server...
start "Dog Emotion Backend" cmd /k "venv\Scripts\activate && cd backend && python app.py"
start "Dog Emotion Frontend" cmd /k "venv\Scripts\activate && cd frontend && python -m http.server 8000"

echo =========================================================================
echo  Backend running at:  http://localhost:5000
echo  Frontend running at: http://localhost:8000
echo =========================================================================
pause
