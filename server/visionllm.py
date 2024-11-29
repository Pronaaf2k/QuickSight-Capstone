import os
import csv
import base64
import time
from datetime import datetime
import numpy as np
import pandas as pd
from openai import OpenAI
from dotenv import load_dotenv
import cv2
from gtts import gTTS

def configure():
    load_dotenv()
    return OpenAI(api_key=os.getenv('OPENAI_API_KEY'))

client = configure()
MODEL = "gpt-4o-mini"

def clear_output_folder(frames_folder):
    try:
        for filename in os.listdir(frames_folder):
            file_path = os.path.join(frames_folder, filename)
            os.remove(file_path)
        print(f"Cleared {frames_folder}")
    except Exception as e:
        print(f"Error clearing folder: {str(e)}")

def capture_and_save_frames(output_folder):
    clear_output_folder(output_folder)
    
    if not os.path.exists(output_folder):
        os.makedirs(output_folder)

    cap = cv2.VideoCapture(0)
    frame_count = 0

    try:
        while True:
            ret, frame = cap.read()
            if not ret:
                break

            timestamp = time.time()
            timestamp_str = datetime.fromtimestamp(timestamp).strftime('%H_%M_%S')
            frame_filename = f"frame_{timestamp_str}.jpg"
            frame_path = os.path.join(output_folder, frame_filename)
            cv2.imwrite(frame_path, frame)
            frame_count += 1
            print(f"Saved frame at {timestamp_str}")

            cv2.imshow('Camera Feed', frame)
            if cv2.waitKey(1) & 0xFF == ord('q'):
                break

            # Wait for 2 seconds before capturing the next frame
            time.sleep(2)

    except KeyboardInterrupt:
        print("Capture interrupted by user")
    finally:
        cap.release()
        cv2.destroyAllWindows()
        print(f"Total frames captured: {frame_count}")
    
    return frame_count


def encode_image(image_path):
    with open(image_path, "rb") as image_file:
        return base64.b64encode(image_file.read()).decode("utf-8")

def process_image(image_path, prompt="Describe this image in one sentence."):
    base64_image = encode_image(image_path)
    
    response = client.chat.completions.create(
        model=MODEL,
        messages=[
            {"role": "system", "content": "You are a helpful assistant that describes images accurately and concisely. The person that you are assisting is a blind person. You will say DANGER if the person if you detect any cars, obtacles, potholes, people, and other dangerous things in close vicinity"},
            {"role": "user", "content": [
                {"type": "text", "text": prompt},
                {"type": "image_url", "image_url": {
                    "url": f"data:image/jpeg;base64,{base64_image}"}
                }
            ]}
        ],
        temperature=0.0,
    )
    
    return response.choices[0].message.content.strip()

def process_frames(frames_folder, output_csv, max_frames=2000):
    with open(output_csv, 'w', newline='') as csvfile:
        csvwriter = csv.writer(csvfile)
        csvwriter.writerow(['Timestamp', 'Description'])
        
        # Sort the frames by their timestamp
        frames = sorted(os.listdir(frames_folder))

        for frame_filename in frames[:max_frames]:
            frame_path = os.path.join(frames_folder, frame_filename)
            timestamp_str = frame_filename.split('_')[1].replace('.jpg', '').replace('_', ':')
            
            description = process_image(frame_path)
            
            csvwriter.writerow([timestamp_str, description])
            
            print(f"Timestamp: {timestamp_str}")
            print(f"Description: {description}")
            print("---")
        
        if len(frames) > max_frames:
            print(f"Note: Only processed the first {max_frames} frames out of {len(frames)} total frames.")


# Function to process frames and save descriptions to CSV
def process_frames(frames_folder, output_csv):
    with open(output_csv, 'w', newline='') as csvfile:
        csvwriter = csv.writer(csvfile)
        csvwriter.writerow(['Timestamp', 'Description'])
        
        frames = sorted(os.listdir(frames_folder))
        
        for frame_filename in frames:
            frame_path = os.path.join(frames_folder, frame_filename)
            timestamp_str = frame_filename.split('_')[1].replace('.jpg', '')
            
            description = process_image(frame_path)
            
            csvwriter.writerow([timestamp_str, description])
            
            print(f"Timestamp: {timestamp_str}")
            print(f"Description: {description}")
            print("---")

def summarize_csv(csv_path):
    df = pd.read_csv(csv_path)
    
    combined_descriptions = " ".join(df['Description'].tolist())
    
    # Correctly format the f-string
    prompt = (f"Please provide a detailed summary of the picture, describing all visible elements "
        "and their arrangement in a coherent paragraph. After the description, identify any "
        "potential dangers or risks of accidents that might be present in the scene. "
        "Format the output as follows:\n\n"
        "Scenery Description:\n"
        "[Your detailed description here]\n\n"
        "**Potential Risks:**\n"
        "[List any potential risks or dangers here]\n\n"
        "Ensure that the description is clear and concise, and use new lines appropriately "
        "to enhance readability. Here is the input description for context: "
        f"{combined_descriptions}"
    )
    
    response = client.chat.completions.create(
        model=MODEL,
        messages=[
            {"role": "system", "content": "You are a helpful assistant that summarizes text accurately and concisely."},
            {"role": "user", "content": prompt}
        ],
        temperature=0.0,
    )
    
    summary = response.choices[0].message.content.strip()
    
    print("Summary of CSV Descriptions:")
    print(summary)

    with open("summary.txt", "w") as f:
        f.write(summary)
    return summary

# def text_to_speech(file_path, output_mp3):
#     # Initialize an empty string to store the text
#     text = ""

#     # Read the text from the file line by line
#     with open(file_path, 'r') as file:
#         for line in file:
#             if "**Potential Risks:**" in line:
#                 break  # Stop reading when "**Potential Risks:**" is encountered
#             text += line

#     # Check if any text was read
#     if text.strip():  # Ensure there's text to convert
#         # Initialize gTTS with the text
#         tts = gTTS(text=text, lang='en', slow=False)

#         # Save the audio to an MP3 file
#         tts.save(output_mp3)
#         print(f"MP3 file saved as {output_mp3}")
#     else:
#         print("No text found before '**Potential Risks:**' to convert to speech.")

def text_to_speech(input_text, output_mp3):
    text = input_text

    if text.strip():
        try:
            tts = gTTS(text=text, lang='en', slow=False)

            tts.save(output_mp3)
            print(f"MP3 file saved as {output_mp3}")
        except Exception as e:
            print(f"Error during text-to-speech conversion: {e}")
    else:
        print("No text found before '**Potential Risks:**' to convert to speech.")
        

# Example usage
summary_file = "summary.txt"
output_mp3 = "scene_summary.mp3"

def generate_risks_tts(file_path):
    # Read from summary.txt starting where "**Potential Risks:**" is written
    def read_from_potential_risks():
        with open(file_path, 'r') as file:
            lines = file.readlines()
        
        start_index = None
        for i, line in enumerate(lines):
            if "**Potential Risks:**" in line:
                start_index = i
                break
        
        if start_index is not None:
            relevant_lines = lines[start_index:]
            return ''.join(relevant_lines).strip()  # Remove leading/trailing whitespace
        else:
            print("The line '**Potential Risks:**' was not found in the file.")
            return ""

    # Extract the relevant text
    risks_text = read_from_potential_risks()

    # Generate MP3 using gTTS
    tts = gTTS(text=risks_text, lang='en', slow=False)
    
    # Save the audio to an MP3 file
    output_mp3 = "risks_summary.mp3"
    tts.save(output_mp3)
    
    print(f"MP3 file saved as {output_mp3}")

# Example usage
file_path = "summary.txt"

def main():
    configure()
    
    # Capture and save frames
    output_folder = "captured_frames"
    frame_count = capture_and_save_frames(output_folder)
    
    # Process frames and save descriptions to CSV
    csv_file = "frame_descriptions.csv"
    process_frames(output_folder, csv_file)
    
    # Summarize CSV
    summary = summarize_csv(csv_file)
    
    # Generate text-to-speech
    text_to_speech("summary.txt", "scene_summary.mp3")
    generate_risks_tts("summary.txt")

if __name__ == "__main__":
    main()
