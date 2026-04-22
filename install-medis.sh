#!/bin/bash
set -e

# Medis AppImage Install Script
# Downloads and installs Medis Redis GUI application

APPIMAGE_URL="https://github.com/luin/medis/releases/download/v1.0.3/Medis-1.0.3.AppImage"
INSTALL_DIR="/opt"
BIN_DIR="/usr/local/bin"
APPIMAGE_NAME="Medis.AppImage"

echo "📦 Downloading Medis AppImage..."
curl -L "$APPIMAGE_URL" -o /tmp/Medis.AppImage

echo "🔧 Installing to $INSTALL_DIR..."
sudo mkdir -p "$INSTALL_DIR"
sudo mv /tmp/Medis.AppImage "$INSTALL_DIR/$APPIMAGE_NAME"
sudo chmod +x "$INSTALL_DIR/$APPIMAGE_NAME"

echo "🔗 Creating symlink in $BIN_DIR..."
sudo ln -sf "$INSTALL_DIR/$APPIMAGE_NAME" "$BIN_DIR/medis"

echo ""
echo "✅ Medis installed successfully!"
echo "Run with: medis"
echo ""
echo "To uninstall:"
echo "  sudo rm -f $INSTALL_DIR/$APPIMAGE_NAME $BIN_DIR/medis"
