#!/bin/bash
# ============================================================
# Script : png2webp.sh
# Description : Convertit toutes les images PNG d’un dossier en WebP
# Usage :
#   ./png2webp.sh <input_folder> <output_folder> [quality]
#
# Arguments :
#   input_folder   : dossier contenant les PNG à convertir
#   output_folder  : dossier où seront enregistrés les WebP
#   quality        : (optionnel) qualité de compression (0 à 100)
#                    - Par défaut : 80
#
# Exemple :
#   ./png2webp.sh ./images_png ./images_webp 75
#   → Convertit tous les PNG de ./images_png en WebP avec qualité 75
#
# Prérequis :
#   - Installer webp : brew install webp (macOS) ou apt install webp (Linux)
# ============================================================

# Vérifie que l'utilisateur a fourni au moins 2 arguments
if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <input_folder> <output_folder> [quality]"
    exit 1
fi

# Récupération des paramètres
INPUT_DIR="$1"             # Dossier d'entrée
OUTPUT_DIR="$2"            # Dossier de sortie
QUALITY="${3:-80}"         # Qualité (par défaut 80 si non précisé)

# Création du dossier de sortie s’il n’existe pas
mkdir -p "$OUTPUT_DIR"

# Boucle sur tous les fichiers PNG du dossier d’entrée
for file in "$INPUT_DIR"/*.png; do
    if [ -f "$file" ]; then
        # Récupère le nom du fichier sans l'extension
        filename=$(basename "$file" .png)

        echo "📷 Conversion de $file -> $OUTPUT_DIR/$filename.webp (qualité: $QUALITY)"
        # Commande de conversion PNG -> WebP
        cwebp "$file" -q "$QUALITY" -o "$OUTPUT_DIR/$filename.webp"
    fi
done

echo "✅ Conversion terminée !"
