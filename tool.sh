#!/bin/bash

# Cisco Firepower Threat Defense Management Center

echo "Dobrodošli u automatizovanu skriptu za vraćanje HTTP requestova u jednom kliku."
sleep 1
echo "Da bi skripta funkcionisala, potrebno je uneti informacije sandbox-a."

# Unos korisničkih podataka - authetication

#read -p "Unesite username Cisco Sandbox-a: " USER
#read -p "Unesite password Cisco Sandbox-a: " PASS
read -p "Unesite Domain ID: " DOMAIN_UUID
read -p "Unesite Token sa FMC GUI-a: " TOKEN

sleep 5 

echo "Uspesno ste se uneli informacije"

# Definisanje URL-a baze
URL="https://fmcrestapisandbox.cisco.com"


# Prikaz TOOL-KIT izaberite opciju - MENI

echo "Izaberite opciju:"
sleep 2 
echo "1) Prikaz svih objekata u mrezi"
echo "2) Prikaz verzije servera"
echo "3) Prikaz informacija o domenu"
read -p "Unesite broj opcije:" OPCIJA


case $OPCIJA in
	1)
		echo "Opcija 1 vrca sve dostupne mreze u JSON dokumentu"
		ENDPOINT="/api/fmc_config/v1/domain/$DOMAIN_UUID/object/networks"
		;;
	2)
		echo "Opcija 2 vraca Verziju i ostale meta-podatke FMC server-a u JSON dokumentu"
		ENDPOINT="/api/fmc_platform/v1/info/serverversion"
		;;
	3)
		echo "Opcija 3 vraca ime domena linkovog za FMC server u JSON dokumentu"
		ENDPOINT="/api/fmc_platform/v1/info/domain"
		;;
	*)
		echo "Nepoznata opcija izlazim iz programa!"
		sleep 3
		exit 1
esac

# Slanje HTTP GET Zahtev-a za svaki case.

RESPO=$(curl -X 'GET' \
  "${URL}${ENDPOINT}" \
  -H "accept: application/json" \
  -H "X-auth-access-token: $TOKEN" \
  )

echo "Rezultat:"
echo "$RESPO" | jq '.'
