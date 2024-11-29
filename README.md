# QuickSight: Junior Capstone Project for CSE299

**QuickSight** is a Flutter-based frontend and Python-based Backend application developed as my **Junior Capstone Project** for **CSE299** at **North South University**. The application addresses accessibility challenges by offering innovative features for individuals with visual impairments or color-related difficulties.

---

## Project Overview

The primary goal of QuickSight is to provide an accessible and inclusive tool that empowers users to overcome challenges related to colorblindness and visual impairments. QuickSight combines **colorblindness simulation** with advanced **AI-powered image-to-text conversion** and **text-to-speech capabilities** to deliver a practical and impactful solution.

---

## Key Features

### 1. **Colorblindness Color Corrections**
QuickSight includes Color Corrections modes for three types of colorblindness:
- **Deuteranopia**: Red-green colorblindness simulation.
- **Tritanopia**: Blue-yellow colorblindness simulation.
- **Protanopia**: Red-green hue differentiation difficulty simulation.

These simulations are designed to help users with colorblindness and raise awareness among individuals without such impairments.

---

### 2. **Quick Sight Tool**
A powerful feature designed to enhance accessibility for visually impaired individuals:
- **Image-to-Text Conversion**: Extracts text from images using the OpenAI API.
- **Text-to-Speech (TTS)**: Converts the extracted text into speech using the `gTTS` (Google Text-to-Speech) library, allowing users to hear the content.

---

## Technologies Used

### Development Tools
- **Flutter**: Framework for cross-platform development.
- **Dart**: Programming language used for Flutter.
- **FastAPI**: Backend framework for managing AI requests.

### APIs and Libraries
- **OpenAI API**: Used for image-to-text conversion.
- **Google Text-to-Speech (gTTS)**: Provides text-to-speech functionality.
- **Camera Plugin**: Captures images for text extraction.

### Python Libraries
The project leverages several Python libraries for backend functionality. Below are the required libraries and installation instructions.

---

## Python Dependencies

### Required Libraries
Here is a list of Python libraries you need to install for the backend:

1. **`numpy`**: For numerical computations.
2. **`pandas`**: For data manipulation and analysis.
3. **`openai`**: To interact with the OpenAI API.
4. **`python-dotenv`**: To load environment variables from a `.env` file.
5. **`fastapi`**: For building the API backend.
6. **`uvicorn`**: To run the FastAPI app.
7. **`gtts`**: For converting text to speech.
8. **`opencv-python`**: For image processing (`cv2` module).
9. **`python-multipart`**: Required by FastAPI for handling file uploads.
10. **`requests`**: For making API requests.

### Installation Command
Install all dependencies using the following command:
```bash
pip install numpy pandas openai python-dotenv fastapi uvicorn gtts opencv-python python-multipart requests
```

### Standard Library
The following modules are part of Python’s standard library and do not require installation:
- `os`, `csv`, `base64`, `time`, `datetime`, `logging`, `shutil`.

---

## Installation

### 1. Clone the Repository
```bash
git clone https://github.com/your-username/QuickSight.git
cd QuickSight
```

### 2. Install Python Dependencies
Install the required Python libraries:
```bash
pip install -r requirements.txt
```
*(Ensure the `requirements.txt` file includes all dependencies listed above.)*

### 3. Install Flutter Dependencies
Navigate to the Flutter project folder and install the required Flutter dependencies:
```bash
flutter pub get
```

### 4. Configure the Environment
Create a `.env` file in the project root and add your OpenAI API key:
```
OPENAI_API_KEY='your-api-key-here'
```

---

## Usage Instructions

### Running the Application
1. Start the FastAPI backend:
   ```bash
   uvicorn main:app --reload
   ```
2. Launch the Flutter frontend:
   ```bash
   flutter run
   ```

### Features Walkthrough
1. **Colorblindness Color Corrections**:
   - Navigate to Colorblind Menu.
   - Choose between Deuteranopia, Tritanopia, or Protanopia modes.
     
2. **Quick Sight Tool**:
   - Tap the lower end of the screen,
   - Automatically the phones camera will turn on.
   - The app will process the text and read it aloud.
   - Tap the screen to go back to home.

---

## Educational Significance

QuickSight was developed to address real-world challenges as part of my **CSE299 Junior Capstone Project** at **North South University**. This project embodies the application of classroom learning to create a tangible and impactful solution for improving accessibility.

---

## Acknowledgements

I would like to express my gratitude to:
- **Muhammad Shafayat Oshman**: For providing guidance throughout the project.
- **North South University, Department of ECE**: For offering the opportunity to develop and showcase this project.
- **OpenAI** and **Google Developers**: For the tools and APIs that made this project possible.

---

## Contact

For questions or feedback, please contact me at:
- 📧 Email: **benaaf2000@gmail.com**
- 🌐 LinkedIn: [Samiyeel Alim Binaaf](https://linkedin.com/in/samiyeel-alim-binaaf)

**QuickSight** – Empowering Accessibility 🌟
