#!/bin/bash
# ============================================================
# Script : gen_webp_scales.sh
# Description : Génère 3 versions (@1x, @2x, @3x) en WebP
# Usage :
#   ./gen_webp_scales.sh <input_file> <output_folder> [quality]
#
# Arguments :
#   input_file     : fichier image source (PNG, JPG, etc.)
#   output_folder  : dossier où seront enregistrées les versions WebP
#   quality        : (optionnel) qualité de compression (0 à 100)
#                    - Par défaut : 80
#
# Exemple :
#   ./gen_webp_scales.sh ./image.png ./images_webp 85
#   → Génère image@1x.webp, image@2x.webp, image@3x.webp
#
# Prérequis :
#   - Installer webp : brew install webp (macOS) ou apt install webp (Linux)
#   - Installer imagemagick : brew install imagemagick / apt install imagemagick
# ============================================================

# Vérifie que l'utilisateur a fourni au moins 2 arguments
if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <input_file> <output_folder> [quality]"
    exit 1
fi

INPUT_FILE="$1"             # Fichier source
OUTPUT_DIR="$2"             # Dossier de sortie
QUALITY="${3:-80}"          # Qualité (par défaut 80 si non précisé)

# Création du dossier de sortie s’il n’existe pas
mkdir -p "$OUTPUT_DIR"

# Nom de base du fichier sans extension
BASENAME=$(basename "$INPUT_FILE")
FILENAME="${BASENAME%.*}"

# Largeur cible (tu peux ajuster la taille max ici)
WIDTH_1X=720
WIDTH_2X=1080
WIDTH_3X=1440

# Génération des versions
echo "📷 Génération des versions WebP pour $INPUT_FILE (qualité: $QUALITY)"

convert "$INPUT_FILE" -resize ${WIDTH_1X} -quality "$QUALITY" "$OUTPUT_DIR/${FILENAME}@1x.webp"
echo "✅ $OUTPUT_DIR/${FILENAME}@1x.webp"

convert "$INPUT_FILE" -resize ${WIDTH_2X} -quality "$QUALITY" "$OUTPUT_DIR/${FILENAME}@2x.webp"
echo "✅ $OUTPUT_DIR/${FILENAME}@2x.webp"

convert "$INPUT_FILE" -resize ${WIDTH_3X} -quality "$QUALITY" "$OUTPUT_DIR/${FILENAME}@3x.webp"
echo "✅ $OUTPUT_DIR/${FILENAME}@3x.webp"

echo "🎉 Conversion terminée avec succès !"
