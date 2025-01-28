#!/bin/bash

# Cisco Firepower Threat Defense Management Center

echo "Kreiranje Test Intrusion Polisa - work in progress - skripta ne radi!"
echo "Potreno je imati Polisu ja korsitim sa CBT nuggets platforme materijal"

sleep 5
read -p "Unesite Domain ID: " DOMAIN_UUID
read -p "Unesite Token sa FMC GUI-a: " TOKEN

URL="https://fmcrestapisandbox.cisco.com"

# Učitaj JSON sa lokalnog servera - koristiti XAMPP ili staviti na neki domen
polisa="$(curl -s http://localhost/JSON/policy.json | jq '.')"

# Provera da li je JSON uspešno preuzet - Simple provera nije potrebno!
if [ -z "$polisa" ] || [ "$polisa" == "null" ]; then
    echo "Greška: Neuspešno preuzimanje JSON fajla!"
    exit 1
fi

echo "Preuzet JSON za Access Policy:"
echo "$polisa" | jq '.'

# API Endpoint za kreiranje Access Policy
ENDPOINT="/api/fmc_config/v1/domain/$DOMAIN_UUID/policy/intrusionpolicies"

# Pošalji POST zahtev za kreiranje Access Policy - kod radi - polisa trenutno ne!
RESPONSE=$(curl -X 'POST' \
  "$URL$ENDPOINT" \
  -H "accept: application/json" \
  -H "Content-Type: application/json" \
  -H "X-auth-access-token: $TOKEN" \
  -d "${polisa}")

# Prikaz odgovora
echo "Odgovor sa FMC servera:"
echo "$RESPONSE" | jq '.'
