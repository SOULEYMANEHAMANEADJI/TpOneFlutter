from flask import Flask, jsonify, request

app = Flask(__name__)

notes = []

# Endpoint pour ajouter une note
@app.route('/notes/add', methods=['POST'])
def add_note():
    data = request.get_json()
    title = data.get('title')
    content = data.get('content')
    
    if title and content:
        new_note = {
            "id": len(notes) + 1,
            "title": title,
            "content": content
        }
        notes.append(new_note)
        return jsonify({"message": "Note ajoutée avec succès"}), 201
    else:
        return jsonify({"message": "Veuillez fournir un titre et un contenu pour la note"}), 400
# Endpoint pour récupérer toutes les notes
@app.route('/notes', methods=['GET'])
def get_all_notes():
    return jsonify(notes)

# Endpoint pour mettre à jour une note
@app.route('/notes/update/<int:id>', methods=['PUT'])
def update_note(id):
    data = request.get_json()
    title = data.get('title')
    content = data.get('content')
    
    for note in notes:
        if note['id'] == id:
            note['title'] = title
            note['content'] = content
            return jsonify({"message": "Note mise à jour avec succès"}), 200
    return jsonify({"message": "Note non trouvée"}), 404

# Endpoint pour supprimer une note
@app.route('/notes/delete/<int:id>', methods=['DELETE'])
def delete_note(id):
    for note in notes:
        if note['id'] == id:
            notes.remove(note)
            return jsonify({"message": "Note supprimée avec succès"}), 200
    return jsonify({"message": "Note non trouvée"}), 404

if __name__ == '__main__':
    app.run(debug=True)