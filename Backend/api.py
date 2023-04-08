from flask import Flask
from flask_restful import Api, Resource

app = Flask(__name__)
api = Api(app)


class test(Resource):
    def get(self, name):
        return {"message": f"Hello {name}"}


api.add_resource(test, "/<string:name>")

if __name__ == "__main__":
    app.run(debug=True)
