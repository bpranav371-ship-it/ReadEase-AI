# ReadEase: AI-Enabled Adaptive Reading Ecosystem 📚✨

**ReadEase** is a multi-sensory reading platform designed to bridge the gap for students with dyslexia and other reading challenges. By combining **Computer Vision**, **Large Language Models (LLMs)**, and **Behavioral Analytics**, ReadEase identifies "Cognitive Friction" in real-time and adapts the learning environment to the student's specific needs.

---

## 🚀 Key Features Implemented

### 1. Adaptive Reading Engine
* **Word-Level Interaction:** Every word is a standalone component tracking user behavior.
* **Dynamic TTS:** Tap any word to hear its pronunciation immediately, providing autonomy without overwhelming the student.
* **Visual Adaptation:** A "Thumb-Zone" settings menu allows for real-time text size adjustment (16px to 42px) and a choice of 7 scientifically backed dyslexia-friendly background colors.

### 2. Magic Teacher (AI Simplification)
* **LLM Integration:** Powered by Google Gemini to transform complex academic jargon into kid-friendly analogies.
* **Contextual Simplification:** Converts abstract concepts like "Dijkstra's Algorithm" into concrete stories like a "toy box" or "family tree".

### 3. Smart Library & Document Management
* **Tab-Based Organization:** A clean, visual folder system to organize saved sessions and AI-generated notes.
* **Personalized Naming:** Users can title their notes (e.g., "Science Chapter 1") for structured study.
* **Full Recursive Reader:** Saved notes open back in the main engine, preserving all TTS and adaptation features.

### 4. Progress & Analytics Dashboard
* **Struggle Word Tracking:** Automatically logs words that a student taps multiple times during a session.
* **Cognitive Load Analysis:** Visualizes "friction points" to help parents and teachers provide targeted support.

---

## 🛠️ Tech Stack
* **Frontend:** Flutter & Dart
* **AI Backend:** Google Gemini Pro API (Generative AI)
* **Computer Vision:** Google ML Kit (Text Recognition)
* **Analytics:** Custom Behavioral Tracking Engine
* **Architecture:** Singleton Service Patterns for persistent data across tabs

---

## 🏗️ Future Roadmap

### 1. Patent Integration & Resource Re-allocation
* **Indian Patent Implementation:** Integrating the logic from our filed patent (**Application: 202521079813**) for AI-enabled dynamic resource re-allocation.
* **Classroom Automation:** Connecting with IoT devices (ESP32/NodeMCU) to adjust the physical learning environment based on real-time focus data.

### 2. Enhanced ML & Vision
* **Deep Learning Integration:** Implementing **YOLOv8** for real-time gaze tracking and posture analysis.
* **Multi-language Support:** Expanding the "Magic Teacher" into regional Indian languages to aid diverse classrooms.

### 3. Gamified Learning
* **Reward System:** Earn badges and XP for reading milestones to increase student engagement.

---

## 📦 Installation

1. **Clone the project:**
   ```bash
   git clone https://github.com/bpranav371-ship-it/ReadEase.gitSetup your Environment:
```Create a .env file in the root and add your Gemini API Key:```

Plaintext
GEMINI_API_KEY=your_api_key_here
Run the app:
```
Bash
flutter pub get
flutter run

Developed by: SYNEXIS


Aimed at : WCE HACKATHON 2026 
