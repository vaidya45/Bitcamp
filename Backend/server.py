from flask import Flask
from flask_restful import Api, Resource, reqparse
import pytesseract
import os
import werkzeug
from werkzeug.utils import secure_filename
from PIL import Image


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
        ALLOWED_EXTENSIONS = {"jpg", "jpeg", "png", "gif"}
        return (
            "." in filename and filename.rsplit(".", 1)[1].lower() in ALLOWED_EXTENSIONS
        )

    def get(self):
        args = parse.parse_args()
        image_file = args["file"]
        if not self.allowed_file(image_file.filename):
            return {"message": "Invalid file type"}, 400
        filename = secure_filename(image_file.filename)
        filepath = os.path.join("Backend/images", filename)
        image_file.save(filepath)
        text = pytesseract.image_to_string(Image.open(filepath, "r"))
        os.remove(filepath)
        return {"message": text}


api.add_resource(ImageProcessing, "/upload")

if __name__ == "__main__":
    app.run(debug=True)
