#!/bin/bash
echo "========================================================================="
echo " Starting Dog Emotion and Distress Detection System (Linux / Raspberry Pi)"
echo "========================================================================="

if [ ! -d "venv" ]; then
    echo "[1/4] Creating virtual environment..."
    python3 -m venv venv
fi

echo "[2/4] Activating environment and installing requirements..."
source venv/bin/activate
pip install -r requirements.txt

echo "[3/4] Initializing database & creating baseline demo model..."
python training/create_demo_model.py
python scripts/initialize_database.py

echo "[4/4] Launching backend server..."
cd backend
python app.py &
BACKEND_PID=$!
cd ..

echo "Backend started with PID $BACKEND_PID on port 5000"
echo "To run device monitor, execute: python device/run_device.py"
echo "========================================================================="
