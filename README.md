# QuickSight: Junior Capstone Project for CSE299

**QuickSight** is a Flutter-based application developed as my **Junior Capstone Project** for **CSE299** at **North South University**. The application addresses accessibility challenges by offering innovative features for individuals with visual impairments or color-related difficulties.

---

## Features

### 1. **Colorblindness Simulations**
QuickSight offers color correction modes to assist users with various types of colorblindness:
- **Deuteranopia Mode**: Red-green colorblindness optimization.
- **Tritanopia Mode**: Blue-yellow colorblindness optimization.
- **Protanopia Mode**: Enhanced for those with difficulty distinguishing red and green hues.

### 2. **Quick Sight Tool**
A core feature that combines cutting-edge AI and text-to-speech technology:
- **Image-to-Text Conversion**: Uses OpenAI's API to extract textual information from an image.
- **Text-to-Speech (TTS)**: Converts the extracted text into spoken words for auditory accessibility.

---

## Installation

### Prerequisites
- Flutter SDK installed ([Get Flutter](https://flutter.dev/docs/get-started/install)).
- A valid OpenAI API key for accessing GPT functionality.
- Ensure you have the necessary dependencies listed in the `pubspec.yaml` file.

### 1. Clone the Repository
```bash
git clone https://github.com/your-username/QuickSight.git
cd QuickSight
```

### 2. Install Dependencies
Run the following command to install all required dependencies:
```bash
flutter pub get
```

### 3. Set Up the `.env` File
Create a `.env` file in the server directory and add your OpenAI API key:
```
OPENAI_API_KEY='your-api-key-here'
```

---

## Usage

### Running the App
To start the app, execute:
```bash
flutter run
```

### Using QuickSight
1. **Colorblindness Simulations**:
   - Navigate to the settings menu to select a colorblindness mode (Deuteranopia, Tritanopia, or Protanopia).
2. **Quick Sight Tool**:
   - Use your device camera or upload an image to extract text.
   - Listen to the extracted text read aloud via the built-in TTS functionality.

---

## Dependencies

QuickSight uses the following Flutter dependencies:

### Main Dependencies
- `provider`
- `go_router`
- `flutter_spinkit`
- `cupertino_icons`
- `camera`
- `flutter_launcher_icons`
- `http`
- `http_parser`
- `mime`
- `just_audio`
- `path_provider`

### Dev Dependencies
- `flutter_test`
- `flutter_lints`

**Note**: Refer to the [pubspec.yaml](pubspec.yaml) file for exact versions.

---

## Built With
- **OpenAI API**: Image-to-text conversion.
- **gTTS (Google Text-to-Speech)**: Text-to-speech functionality.
- **Flutter**: Frontend framework for mobile development.

---

## Contributing
We welcome contributions! If you’d like to improve QuickSight, please follow these steps:
1. Fork the repository.
2. Create a feature branch (`git checkout -b feature-name`).
3. Commit your changes (`git commit -m 'Add feature-name'`).
4. Push the branch (`git push origin feature-name`).
5. Open a pull request.

---

## Contact
For questions or support, feel free to reach out at `benaaf2000@gmail.com`.

Enjoy using **QuickSight**! 🌟
