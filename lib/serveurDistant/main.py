from flask import Flask, jsonify, request

app = Flask(__name__)

notes = [
    {"id": 1, "title": "Note 1", "content": "Contenu de la note 1"},
    {"id": 2, "title": "Note 2", "content": "Contenu de la note 2"}
]

def display_menu():
    print("1. Ajouter une note")
    print("2. Lire une note")
    print("3. Modifier une note")
    print("4. Supprimer une note")
    print("5. Quitter")

def add_note():
    title = input("Entrez le titre de la note : ")
    content = input("Entrez le contenu de la note : ")
    new_note = {
        "id": len(notes) + 1,
        "title": title,
        "content": content
    }
    notes.append(new_note)
    print("Note ajoutée avec succès.")

def read_note():
    note_id = int(input("Entrez l'ID de la note que vous souhaitez lire : "))
    for note in notes:
        if note['id'] == note_id:
            print(f"Titre : {note['title']}")
            print(f"Contenu : {note['content']}")
            return
    print("Note non trouvée.")

def update_note():
    note_id = int(input("Entrez l'ID de la note que vous souhaitez modifier : "))
    for note in notes:
        if note['id'] == note_id:
            new_title = input("Entrez le nouveau titre de la note : ")
            new_content = input("Entrez le nouveau contenu de la note : ")
            note['title'] = new_title
            note['content'] = new_content
            print("Note modifiée avec succès.")
            return
    print("Note non trouvée.")

def delete_note():
    note_id = int(input("Entrez l'ID de la note que vous souhaitez supprimer : "))
    for note in notes:
        if note['id'] == note_id:
            notes.remove(note)
            print("Note supprimée avec succès.")
            return
    print("Note non trouvée.")

@app.route('/notes', methods=['GET'])
def handle_notes():
    return jsonify(notes)

@app.route('/notes/<int:id>', methods=['GET'])
def handle_note(id):
    for note in notes:
        if note['id'] == id:
            return jsonify(note)
    return jsonify({"message": "Note not found"}), 404

if __name__ == '__main__':
    app.run(debug=True)

while True:
    display_menu()
    choice = input("Choisissez une option : ")

    if choice == '1':
        add_note()
    elif choice == '2':
        read_note()
    elif choice == '3':
        update_note()
    elif choice == '4':
        delete_note()
    elif choice == '5':
        print("Au revoir !")
        break
    else:
        print("Option invalide. Veuillez choisir une option valide.")
