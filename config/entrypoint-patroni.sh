#!/bin/sh
set -e

echo "Installation de Patroni..."

# Installer les dépendances
apk add --no-cache python3 py3-pip py3-psycopg2 curl gcc python3-dev musl-dev

# Installer Patroni avec support etcd3
pip3 install --break-system-packages patroni[etcd3]

# Créer le répertoire pour les données si nécessaire
mkdir -p /home/postgres/data

# Définir les bonnes permissions (0700 requis par PostgreSQL)
chown -R postgres:postgres /home/postgres/data
chmod 700 /home/postgres/data

echo "Patroni installé"
echo "Démarrage de Patroni avec la config /etc/patroni.yml"

# Démarrer Patroni en tant qu'utilisateur postgres
exec su-exec postgres patroni /etc/patroni.yml
