#!/bin/bash

# Cisco Firepower Threat Defense Management Center

echo "Dobrodošli u automatizovanu skriptu za vraćanje HTTP requestova u jednom kliku."
sleep 1
echo "Da bi skripta funkcionisala, potrebno je uneti informacije sandbox-a."

# Unos korisničkih podataka
#read -p "Unesite username Cisco Sandbox-a: " USER
#read -p "Unesite password Cisco Sandbox-a: " PASS
read -p "Unesite Domain ID: " DOMAIN_UUID
read -p "Unesite Token sa FMC GUI-a: " TOKEN

# Definisanje URL-a baze
URL="https://fmcrestapisandbox.cisco.com"

# PRVA OPCIJA - Vratiti nazad sve objekte u mreži.

RESPO=$(curl -X 'GET' \
  "${URL}/api/fmc_config/v1/domain/$DOMAIN_UUID/object/networks" \
  -H "accept: application/json" \
  -H "X-auth-access-token: $TOKEN" \
  )

# Prikaz odgovora formatiranog sa jq
echo "$RESPO" | jq '.'
