from flask import Flask
from flask_restful import Api, Resource, reqparse
import pytesseract
import io
import werkzeug
from PIL import Image
import cv2
import numpy as np


app = Flask(__name__)
api = Api(app)

parse = reqparse.RequestParser()
parse.add_argument(
    "file",
    type=werkzeug.datastructures.FileStorage,
    location="files",
    help="Image Failed OCR",
    required=True,
)


class ImageProcessing(Resource):
    def allowed_file(self, filename):
        ALLOWED_EXTENSIONS = {"jpg", "jpeg", "png"}
        return (
            "." in filename and filename.rsplit(".", 1)[1].lower() in ALLOWED_EXTENSIONS
        )

    def preprocess_image(self, image):
        # Convert image to grayscale
        gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
        
        # Apply adaptive thresholding to enhance text
        thresh = cv2.adaptiveThreshold(gray, 255, cv2.ADAPTIVE_THRESH_GAUSSIAN_C, cv2.THRESH_BINARY_INV, 11, 2)
        
        # Apply median filtering to remove noise
        median = cv2.medianBlur(thresh, 3)
        
        # Apply dilation to enhance text
        kernel = np.ones((2,2), np.uint8)
        dilation = cv2.dilate(median, kernel, iterations=1)
        
        return dilation

    # def preprocess_image(self, image):
    #     # Convert the image to grayscale
    #     gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

    #     # Apply adaptive thresholding to the image
    #     thresh = cv2.adaptiveThreshold(
    #         gray, 255, cv2.ADAPTIVE_THRESH_MEAN_C, cv2.THRESH_BINARY_INV, 11, 2
    #     )

    #     # Perform morphological operations to remove noise and fill gaps in the image
    #     kernel = np.ones((3, 3), np.uint8)
    #     opening = cv2.morphologyEx(thresh, cv2.MORPH_OPEN, kernel, iterations=1)
    #     closing = cv2.morphologyEx(opening, cv2.MORPH_CLOSE, kernel, iterations=1)

    #     return closing

    def get(self):
        args = parse.parse_args()
        image_file = args["file"]
        if not self.allowed_file(image_file.filename):
            return {"message": "Invalid file type"}, 400
        image_data = image_file.read()

        # Load the image using OpenCV
        img = cv2.imdecode(np.fromstring(image_data, np.uint8), cv2.IMREAD_COLOR)

        # Preprocess the image
        preprocessed_img = self.preprocess_image(img)

        # Run the OCR process on the preprocessed image
        text = pytesseract.image_to_string(
            Image.fromarray(preprocessed_img), lang="eng"
        ).replace("\n", "")

        return {"message": text}


api.add_resource(ImageProcessing, "/upload")

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=9080, debug=True)
