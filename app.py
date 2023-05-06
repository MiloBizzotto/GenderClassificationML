from flask import Flask,request
from flask_restful import Resource, Api
import pickle
import pandas as pd
from flask_cors import CORS


app = Flask(__name__)
#
CORS(app)
# creating an API object
api = Api(app)

#prediction api call
class prediction(Resource):
    def get(self,p1,p2,p3,p4,p5,p6):
        # Let's load the package
        d = {'forehead_width_cm':[p1],'forehead_height_cm':[p2],'nose_wide':[p3],'nose_long':[p4],'lips_thin':[p5],'distance_nose_to_lip_long':[p6]}
        df = pd.DataFrame(d)
        print(df)
        model = pickle.load(open('modello.pkl', 'rb'))
        prediction = model.predict(df)
        prediction = int(prediction[0])
        if(prediction == 1) : 
            str = {"genere":"donna"}
        else: str = {"genere":"uomo"}
        return str
    
api.add_resource(prediction, '/prediction/<float:p1>/<float:p2>/<int:p3>/<int:p4>/<int:p5>/<int:p6>')

if __name__ == '__main__':
    app.run(debug = "false")
