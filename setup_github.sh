#!/bin/bash
# ============================================================
# Script para inicializar el repositorio y subirlo a GitHub
# ============================================================
# USO:
#   1. Crear el repo VACÍO en https://github.com/new
#      Nombre: tpi-voz-tf  |  Sin README, sin .gitignore
#   2. Ejecutar este script desde la raíz del proyecto:
#        bash setup_github.sh TU_USUARIO_GITHUB
# ============================================================

set -e

USUARIO="${1:-TU_USUARIO}"
REPO="tpi-voz-tf"
REMOTE="https://github.com/${USUARIO}/${REPO}.git"

echo "==> Inicializando repositorio git..."
git init
git branch -M main

echo "==> Agregando todos los archivos..."
git add .
git status

echo "==> Primer commit..."
git commit -m "feat: estructura inicial del TPI de voz con TF

- README con descripción y guía de uso
- .gitignore (datos, caché, entornos)
- requirements.txt (librosa, scipy, matplotlib)
- Carpetas: data/, notebooks/, figuras/, informe/
- 4 notebooks: exploración, preprocesamiento, TF, resultados"

echo "==> Agregando remote: ${REMOTE}"
git remote add origin "${REMOTE}"

echo "==> Haciendo push a GitHub..."
git push -u origin main

echo ""
echo "✓ Repositorio subido exitosamente."
echo "  Ver en: https://github.com/${USUARIO}/${REPO}"
