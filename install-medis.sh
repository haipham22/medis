#!/bin/bash
set -e

# Medis AppImage Install Script
# Downloads and installs Medis Redis GUI application

# Configuration
REPO="${REPO:-haipham22/medis}"
VERSION="${VERSION:-latest}"
INSTALL_DIR="/opt"
BIN_DIR="/usr/local/bin"
APPIMAGE_NAME="Medis.AppImage"

echo "🔍 Detecting latest version..."
if [ "$VERSION" = "latest" ]; then
  # Get latest release tag from GitHub API
  VERSION=$(curl -s "https://api.github.com/repos/${REPO}/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1')

  if [ -z "$VERSION" ]; then
    echo "❌ Failed to detect latest version. Please specify VERSION manually:"
    echo "   VERSION=v1.0.3 ./install-medis.sh"
    exit 1
  fi

  echo "✓ Found version: ${VERSION}"
else
  echo "✓ Using version: ${VERSION}"
fi

APPIMAGE_URL="https://github.com/${REPO}/releases/download/${VERSION}/Medis-${VERSION#v}.AppImage"

echo "📦 Downloading Medis AppImage from ${REPO}..."
if ! curl -L "$APPIMAGE_URL" -o /tmp/Medis.AppImage; then
  echo "❌ Failed to download AppImage from:"
  echo "   $APPIMAGE_URL"
  echo ""
  echo "Troubleshooting:"
  echo "1. Check if the release exists: https://github.com/${REPO}/releases"
  echo "2. Specify version manually: VERSION=v1.0.3 REPO=luin/medis ./install-medis.sh"
  exit 1
fi

echo "🔧 Installing to ${INSTALL_DIR}..."
sudo mkdir -p "$INSTALL_DIR"
sudo mv /tmp/Medis.AppImage "${INSTALL_DIR}/${APPIMAGE_NAME}"
sudo chmod +x "${INSTALL_DIR}/${APPIMAGE_NAME}"

echo "🔗 Creating symlink in ${BIN_DIR}..."
sudo ln -sf "${INSTALL_DIR}/${APPIMAGE_NAME}" "${BIN_DIR}/medis"

echo ""
echo "✅ Medis ${VERSION} installed successfully!"
echo "Run with: medis"
echo ""
echo "To uninstall:"
echo "  sudo rm -f ${INSTALL_DIR}/${APPIMAGE_NAME} ${BIN_DIR}/medis"
