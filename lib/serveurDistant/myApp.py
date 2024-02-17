from flask import Flask, jsonify
import requests

app = Flask(__name__)

# Endpoint pour récupérer les données depuis Firebase
@app.route('/get_firebase_data', methods=['GET'])
def get_firebase_data():
    firebase_url = 'https://console.firebase.google.com/u/0/project/endtpone/firestore/data/notes'  # Remplacez avec votre URL Firebase
    response = requests.get(firebase_url)
    
    if response.status_code == 200:
        data = response.json()
        return jsonify(data)
    else:
        return jsonify({"message": "Erreur lors de la récupération des données depuis Firebase"}), 500

if __name__ == '__main__':
    app.run(debug=True)
