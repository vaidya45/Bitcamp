from flask import Flask
from flask_restful import Api, Resource, reqparse
import pytesseract
import io
import werkzeug
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
            "." in filename and filename.rsplit(
                ".", 1)[1].lower() in ALLOWED_EXTENSIONS
        )

    def get(self):
        args = parse.parse_args()
        image_file = args["file"]
        if not self.allowed_file(image_file.filename):
            return {"message": "Invalid file type"}, 400
        image_data = image_file.read()
        text = pytesseract.image_to_string(Image.open(io.BytesIO(image_data)))
        return {"message": text}


api.add_resource(ImageProcessing, "/upload")

if __name__ == "__main__":
    app.run(debug=True)
