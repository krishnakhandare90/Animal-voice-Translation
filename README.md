# Explainable AI-Based Dog Emotion and Distress Detection Using IoT-Enabled Vocalization Analysis for Animal Welfare Monitoring

An end-to-end academic IoT and Machine Learning system that classifies probable dog vocalization states (`normal`, `excited`, `stress`, `aggressive`, `attention`, `hunger`, `washroom`, `injury`) to monitor animal welfare.

> **Academic & Welfare Framing**: This project estimates **probable vocalization-related affective or behavioral states**. It does **not** claim to literally translate dog language or provide veterinary medical diagnoses.

---

## 🌟 Key Features

- **8 Vocalization Welfare States**: `normal`, `excited`, `stress`, `aggressive`, `attention`, `hunger`, `washroom`, `injury`.
- **Explainable AI Pipeline**: Extracts 90 acoustic features (40 MFCC means & stds, RMS, ZCR, Spectral Centroid, Bandwidth, Roll-off) with confidence metrics and safe interpretations.
- **Out-of-the-Box Demo Mode**: Includes `training/create_demo_model.py` so the application runs immediately without requiring a pre-collected raw dataset.
- **Flask REST API & JWT Auth**: Secure user registration, role-based access (Admin/User), password hashing, rate limits, and audit logs.
- **Responsive Dashboard**: Glassmorphic HTML5/CSS3/Vanilla JS UI with interactive Chart.js graphs and browser microphone recording (`MediaRecorder`).
- **ESP32 & ESP32-S3 Microcontroller Edge Node**: Native C++/Arduino & PlatformIO firmware supporting I2S MEMS mic audio capture (INMP441), raw binary WAV streaming over HTTP REST, SSD1306 OLED UI display, and hardware GPIO indicators (Green/Yellow/Red LEDs + Buzzer).
- **Raspberry Pi 4 IoT Integration**: Continuous audio recording, REST API reporting, and GPIO hardware alerts.


---

## 🚀 Quick Start Instructions (Windows)

### 1. Automated Execution
Double-click `run_local_windows.bat` or execute in Command Prompt:
```cmd
run_local_windows.bat
```

### 2. Manual Step-by-Step Execution
1. **Create Virtual Environment**:
   ```cmd
   python -m venv venv
   venv\Scripts\activate
   ```
2. **Install Dependencies**:
   ```cmd
   pip install -r requirements.txt
   ```
3. **Initialize Database & Seed Baseline Model**:
   ```cmd
   python training/create_demo_model.py
   python scripts/initialize_database.py
   ```
4. **Run Flask Backend**:
   ```cmd
   cd backend
   python app.py
   ```
   *Backend running at `http://localhost:5000`*

5. **Run Frontend Web Server**:
   In a new terminal window:
   ```cmd
   venv\Scripts\activate
   cd frontend
   python -m http.server 8000
   ```
6. **Open Dashboard**:
   Navigate to `http://localhost:8000` in your web browser.

---

## 🔐 Development Credentials

| Role | Email Address | Password |
|---|---|---|
| **Admin** | `admin@dogemotion.local` | `Admin@12345` |
| **Demo User** | `demo@dogemotion.local` | `Demo@12345` |
| **Default Pi Token** | `dev_device_token_12345` | N/A |

*Warning: Change these default credentials before production deployment.*

---

## 🍓 Raspberry Pi 4 Device Setup

1. **Install Dependencies**:
   ```bash
   sudo apt update && sudo apt install -y python3-pip python3-venv git ffmpeg portaudio19-dev alsa-utils
   ```
2. **Clone/Copy Project & Create Environment**:
   ```bash
   python3 -m venv venv
   source venv/bin/activate
   pip install -r requirements.txt
   ```
3. **Configure Device Settings** (`device/config.py`):
   Set `BACKEND_URL` to your laptop's Wi-Fi IP address (e.g., `http://192.168.1.100:5000/api`).
4. **Run Device Diagnostics & Continuous Monitor**:
   ```bash
   python device/health_check.py
   python device/run_device.py
   ```

---

## ⚡ ESP32 & ESP32-S3 Microcontroller Setup

1. **Hardware Wiring**: Connect INMP441 I2S mic (`WS: GPIO25`, `SCK: GPIO33`, `SD: GPIO32`), LEDs (`Green: 17`, `Yellow: 18`, `Red: 19`), Buzzer (`23`), and SSD1306 OLED (`SDA: 21`, `SCL: 22`).
2. **Firmware Configuration**: Edit `esp32/include/config.h` to set your local Wi-Fi router SSID/password and backend IP endpoint (`SERVER_URL`).
3. **Flashing Firmware**:
   - **Arduino IDE**: Open `esp32/esp32_dog_monitor.ino` and upload to your ESP32 board.
   - **PlatformIO**: Open `esp32/` directory and run `pio run --target upload`.
4. **Hardware Simulator**: Test backend response without physical ESP32 hardware:
   ```bash
   python esp32/tools/esp32_simulator.py http://127.0.0.1:5000 dev_tok_esp32_demo
   ```
5. See [docs/esp32_setup_guide.md](docs/esp32_setup_guide.md) for full schematics and pin tables.


## 🧪 Running Unit Tests

Run the full pytest suite:
```bash
pytest backend/tests/
```

---

## 🛠️ Model Retraining with Custom Audio

To train on your own dog vocalization dataset:
1. Place WAV files into `dataset/raw/<class_name>/` (e.g. `dataset/raw/normal/`).
2. Run feature extraction and training:
   ```bash
   python training/train_model.py
   ```
3. Evaluate model performance:
   ```bash
   python training/evaluate_model.py
   ```

---

## ❓ Troubleshooting

- **Microphone Not Found**: Verify ALSA audio device name with `arecord -l` and update `AUDIO_DEVICE` in `device/config.py`.
- **CORS Error**: Ensure `FRONTEND_ORIGIN` in `.env` matches your frontend port (default `http://localhost:8000`).
- **Missing Model Files**: Run `python training/create_demo_model.py` to regenerate baseline demo model artifacts.
