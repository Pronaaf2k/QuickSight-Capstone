from fastapi import FastAPI, File, UploadFile
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse, FileResponse
import shutil
import os
from visionllm import process_image, text_to_speech
import logging

# Set up basic logging
logging.basicConfig(level=logging.DEBUG)
logger = logging.getLogger(__name__)

app = FastAPI()

origins = [
    "http://localhost",
    "http://localhost:3000",
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["GET", "POST"],
    allow_headers=["*"],
)


@app.post("/image-process/")
async def image_process(file: UploadFile = File(...)):
    try:
        temp_file_path = f"temp_{file.filename}"

        with open(temp_file_path, "wb") as buffer:
            shutil.copyfileobj(file.file, buffer)

        description = process_image(temp_file_path)
        audio_path = "scene_summary.mp3"
        text_to_speech(description, audio_path)

        os.remove(temp_file_path)

        return FileResponse(audio_path, media_type="audio/mpeg", filename="scene_summary.mp3")

    except Exception as e:
        logger.error("Error occurred during image processing: %s", str(e), exc_info=True)
        return {"error": str(e)}, 500
