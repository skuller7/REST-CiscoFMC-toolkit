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
echo "1) Prikaz Objekata"
echo "2) Prikaz Uredj-a"
echo "3) Prikaz Zdradvlja sistema"
echo "4) Prikaz Korisnickih informacija"
echo "5) Prikaz Politike rada"

read -p "Unesite broj kategorije:" KATEGORIJA


case $KATEGORIJA in
	1)
		echo "Izabrali ste: Objekti"
		echo "#######################################"
		echo "1) Prikaz svih mreznih objekata"
		echo "2) Prikaz svih mreznih hostova"
		echo "3) Prikaz svih mreznih grupa"
		echo "4) Prikaz svih ipv4 addressa"
		echo "5) Prikaz svih portova"
		echo "6) Prikaz svih mreznih bezbednosnih zona"
		echo "7) Prikaz svih dostupnih VLAN-ova unutar mreza"
		read -p "Unesite broj opcije: " OPCIJA
		
		case $OPCIJA in
			1)
				ENDPOINT="/api/fmc_config/v1/domain/$DOMAIN_UUID/object/networks"
				;;
			2)
				ENDPOINT="/api/fmc_config/v1/domain/$DOMAIN_UUID/object/hosts"
				;;
			3)
				ENDPOINT="/api/fmc_config/v1/domain/$DOMAIN_UUID/object/networkgroups"
				;;
			4)
				ENDPOINT="/api/fmc_config/v1/domain/$DOMAIN_UUID/object/networkaddresses"
				;;
			5)
				ENDPOINT="/api/fmc_config/v1/domain/$DOMAIN_UUID/object/ports"
				;;
			6)
				ENDPOINT="/api/fmc_config/v1/domain/$DOMAIN_UUID/object/securityzones"
				;;
			7) 
				ENDPOINT="/api/fmc_config/v1/domain/$DOMAIN_UUID/object/vlantags"
				;;
			*)
				echo "Nepoznata opcija, izlazim!"
				exit 1
				;;
		esac
		;;
	2)
		echo "Izabrali ste: Devices"
		echo "#######################################"
		echo "1) Prikaz svih evidencija uredj-a"
		echo "2) Prikaz svih evidentiranih podesavanja uredj-a "
		read -p "Unesite broj opcije: " OPCIJA
		
		case $OPCIJA in
			1)
				ENDPOINT="/api/fmc_config/v1/domain/$DOMAIN_UUID/devices/devicerecords"
				;;
			2)
				ENDPOINT="/api/fmc_config/v1/domain/$DOMAIN_UUID/devices/devicesettings"
				;;
			*)
				echo "Nepoznata opcija, izlazim!"
				exit 1
				;;
		esac
		;;
	3)
		echo "Izabrali ste: Health FMC"
		echo "#######################################"
		echo "1) Prikaz status-a virtuelnih tunel-a"
		echo "2) Prikaz sumerizovanih virtuelnih tunel-a"
		echo "3) Prikaz zdravlja samog FMC uredj-a u obliku upozorenja"
		echo "4) Prikaz zdravlja samog FMC uredj-a u obliku metrike"
		read -p "Unesite broj opcije: " OPCIJA
		
		case $OPCIJA in
			1)
				ENDPOINT="/api/fmc_config/v1/domain/$DOMAIN_UUID/health/tunnelstatuses"
				;;
			2)
				ENDPOINT="/api/fmc_config/v1/domain/$DOMAIN_UUID/health/tunnelsummaries"
				;;
			3)
				ENDPOINT="/api/fmc_config/v1/domain/$DOMAIN_UUID/health/alerts"
				;;
			4)
				ENDPOINT="/api/fmc_config/v1/domain/$DOMAIN_UUID/health/metrics"
				;;			
			*)
				echo "Nepoznata opcija, izlazim!"
				exit 1
				;;
		esac
		;;
	4)
		echo "Izabrali ste: Users"
		echo "#######################################"
		echo "1) Prikaz registrovanih korisnika i njhovih uloga"
		echo "2) Prikaz registrovanih korisnika putem SSO logovanja"
		echo "3) Prikaz registrovanih korisnika putem duoconfig-a"
		read -p "Unesite broj opcije: " OPCIJA
		
		case $OPCIJA in
			1)
				ENDPOINT="/api/fmc_config/v1/domain/$DOMAIN_UUID/users/authroles"
				;;
			2)
				ENDPOINT="/api/fmc_config/v1/domain/$DOMAIN_UUID/users/ssoconfigs"
				;;
			3)
				ENDPOINT="/api/fmc_config/v1/domain/$DOMAIN_UUID/users/duoconfigs"
			*)
				echo "Nepoznata opcija, izlazim!"
				exit 1
				;;
		esac
		;;
	5)
		echo "Izabrali ste: Policy"
		echo "#######################################"
		echo "1) Prikaz politika prava access-policy"
		echo "2) Prikaz politika prava vezane za NAT protokol"
		echo "3) Prikaz politika prava vezne za Intrusion DS/PS"
		read -p "Unesite broj opcije: " OPCIJA
		
		case $OPCIJA in
			1)
				ENDPOINT="/api/fmc_config/v1/domain/$DOMAIN_UUID/policy/accesspolicies"
				;;
			2)
				ENDPOINT="/api/fmc_config/v1/domain/$DOMAIN_UUID/policy/ftdnatpolicies"
				;;
			3)
				ENDPOINT="/api/fmc_config/v1/domain/$DOMAIN_UUID/policy/intrusionpolicies"
			*)
				echo "Nepoznata opcija, izlazim!"
				exit 1
				;;
		esac
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
