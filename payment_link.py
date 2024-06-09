from flask import Flask, request, jsonify
from flask_cors import CORS
from xrpl.clients import JsonRpcClient
from xrpl.wallet import Wallet
from xrpl.models.transactions import Payment
from xrpl.utils import xrp_to_drops
from xrpl.transaction import submit_and_wait
import os
from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()

app = Flask(__name__)
CORS(app, resources={r"/*": {"origins": "*"}})  # Allow all origins

JSON_RPC_URL = "https://s.devnet.rippletest.net:51234/"  # Devnet URL
client = JsonRpcClient(JSON_RPC_URL)

# Load wallet information from environment variables
ADDRESS1_SEED = os.getenv('Address1SEED')
ADDRESS2_SEED = os.getenv('Address2SEED')

# Debugging statements to check environment variables
print(f"ADDRESS1_SEED: {ADDRESS1_SEED}")
print(f"ADDRESS2_SEED: {ADDRESS2_SEED}")

# Verify environment variables are loaded correctly
if not ADDRESS1_SEED or not ADDRESS2_SEED:
    raise ValueError("Environment variables for wallet seeds are not set properly.")

# Create wallet instances from seeds
RECEIVER_WALLET = Wallet.from_seed(ADDRESS1_SEED)
SENDER_WALLET = Wallet.from_seed(ADDRESS2_SEED)

# Debugging statements to check wallet initialization
print(f"RECEIVER_WALLET classic address: {RECEIVER_WALLET.classic_address}")
print(f"SENDER_WALLET classic address: {SENDER_WALLET.classic_address}")

@app.route('/generate_payment_link', methods=['POST'])
def generate_payment_link():
    data = request.json
    address = data.get('address')
    amount = data.get('amount')
    currency = data.get('currency', 'XRP')  # Default to XRP if no currency is specified

    if not address or not amount or not currency:
        return jsonify({"error": "Invalid data"}), 400

    # Generate a payment link (for simplicity, we're just returning a URL with query params)
    payment_link = f"http://localhost:3000/confirm_payment?address={address}&amount={amount}&currency={currency}"
    return jsonify({"payment_link": payment_link})

@app.route('/make_payment', methods=['POST'])
def make_payment():
    data = request.json
    receiver_address = data.get('address')
    amount = data.get('amount')

    if not receiver_address or not amount:
        return jsonify({"error": "Invalid data"}), 400

    try:
        amount = float(amount)  # Convert amount to a float
    except ValueError:
        return jsonify({"error": "Amount must be a number"}), 400

    payment = Payment(
        account=SENDER_WALLET.classic_address,
        amount=xrp_to_drops(amount),
        destination=receiver_address
    )

    response = submit_and_wait(payment, client, SENDER_WALLET)

    return jsonify({"result": response.result})

if __name__ == '__main__':
    app.run(debug=True)
