from flask import Flask, request, jsonify
from PIL import Image
import werkzeug
app = Flask(__name__)

@app.route('/upload', methods=["POST"])
def upload():
    if request.method == "POST" :
        imagefile = request.files['image']
        image = Image.open(imagefile.stream)
        image.show()
        # Getting the base name of the file name
        # filename = werkzeug.utils.secure_filename(imagefile.filename)
        print("\nReceived image File name : " + imagefile.filename)
        # Storing this image at this location
        # imagefile.save("./uploadedimages/" + filename)
        
        return jsonify({
            "message": "Image Uploaded Successfully ",
        })

if __name__ == "__main__":
    app.run(debug=True, port=9000)