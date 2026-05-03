from flask import Flask, request, jsonify
from db_utils import get_connection

app = Flask(__name__)

# GET all the destinations
@app.get("/destinations")
def get_destinations():
    conn = get_connection()
    cursor = conn.cursor(dictionary=True)

    cursor.execute("SELECT * FROM Destination")
    results = cursor.fetchall()

    cursor.close()
    conn.close()

    return jsonify(results), 200

#GET specific destination by id
@app.get("/destinations/1")
def get_destination(country_id):
    conn = get_connection()
    cursor = conn.cursor(dictionary=True)

    cursor.execute("SELECT * FROM Destination WHERE country_id = %s", (country_id,))
    result = cursor.fetchone()

    cursor.close()
    conn.close()

    if result:
        return jsonify(result), 200
    return jsonify({"error": "Destination not found"}), 404


# POST create a new destination
@app.post("/destinations")
def add_destination():
    data = request.get_json()

    country = data.get("country")
    city = data.get("city")

    if not country or not city:
        return jsonify({"error": "country and city are required"}), 400

    conn = get_connection()
    cursor = conn.cursor()

    cursor.execute(
        "INSERT INTO Destination (country, city) VALUES (%s, %s)",
        (country, city)
    )
    conn.commit()

    new_id = cursor.lastrowid

    cursor.close()
    conn.close()

    return jsonify({
        "message": "Destination added",
        "country_id": new_id,
        "country": country,
        "city": city
    }), 201

# PUT update a destination
@app.put("/destinations/2")
def update_destination(country_id):
    data = request.get_json()
    new_country = data.get("country")
    new_city = data.get("city")

    conn = get_connection()
    cursor = conn.cursor()

    cursor.execute(
        "UPDATE Destination SET country = %s, city = %s WHERE country_id = %s",
        (new_country, new_city, country_id)
    )
    conn.commit()

    updated = cursor.rowcount

    cursor.close()
    conn.close()

    if updated == 0:
        return jsonify({"error": "Destination not found"}), 404

    return jsonify({
        "message": "Destination updated",
        "country_id": country_id,
        "country": new_country,
        "city": new_city
    }), 200



# DELETE a destination
@app.delete("/destinations/2")
def delete_destination(country_id):
    conn = get_connection()
    cursor = conn.cursor()

    cursor.execute("DELETE FROM Destination WHERE country_id = %s", (country_id,))
    conn.commit()

    deleted = cursor.rowcount

    cursor.close()
    conn.close()

    if deleted == 0:
        return jsonify({"error": "Destination not found"}), 404

    return jsonify({"message": "Destination deleted"}), 200

# Run app
if __name__ == "__main__":
    app.run(debug=True)
