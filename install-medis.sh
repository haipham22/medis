#!/bin/bash
set -e

# Medis Install Script (Cross-Platform)
# Downloads and installs Medis Redis GUI application
# Supports: Linux (AppImage) and macOS (DMG)

# Configuration
REPO="${REPO:-haipham22/medis}"
VERSION="${VERSION:-latest}"

# Detect platform
OS="$(uname -s)"
case "${OS}" in
  Linux*)     PLATFORM=linux;;
  Darwin*)    PLATFORM=mac;;
  *)          echo "❌ Unsupported OS: ${OS}" && exit 1;;
esac

echo "🖥️  Detected platform: ${PLATFORM}"
echo "🔍 Detecting latest version..."

# Get version
if [ "$VERSION" = "latest" ]; then
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

# Platform-specific installation
if [ "$PLATFORM" = "linux" ]; then
  # Linux installation (AppImage)
  INSTALL_DIR="/opt"
  BIN_DIR="/usr/local/bin"
  APPIMAGE_NAME="Medis.AppImage"
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

elif [ "$PLATFORM" = "mac" ]; then
  # macOS installation (DMG)
  DMG_URL="https://github.com/${REPO}/releases/download/${VERSION}/Medis-${VERSION#v}.dmg"
  DMG_PATH="/tmp/Medis-${VERSION#v}.dmg"
  APP_NAME="Medis.app"
  APPS_DIR="/Applications"

  echo "📦 Downloading Medis DMG from ${REPO}..."
  if ! curl -L "$DMG_URL" -o "$DMG_PATH"; then
    echo "❌ Failed to download DMG from:"
    echo "   $DMG_URL"
    echo ""
    echo "Troubleshooting:"
    echo "1. Check if the release exists: https://github.com/${REPO}/releases"
    echo "2. Specify version manually: VERSION=v1.0.3 REPO=luin/medis ./install-medis.sh"
    exit 1
  fi

  echo "🔧 Installing to ${APPS_DIR}..."
  # Mount DMG
  MOUNT_DIR=$(hdiutil attach "$DMG_PATH" | grep -E '/Volumes/.*' | awk '{print $3}')

  if [ -z "$MOUNT_DIR" ]; then
    echo "❌ Failed to mount DMG"
    exit 1
  fi

  # Copy app to Applications
  sudo cp -R "${MOUNT_DIR}/${APP_NAME}" "${APPS_DIR}/"
  sudo xattr -dr com.apple.quarantine "${APPS_DIR}/${APP_NAME}"

  # Unmount DMG
  hdiutil detach "$MOUNT_DIR" > /dev/null 2>&1 || true
  rm -f "$DMG_PATH"

  echo ""
  echo "✅ Medis ${VERSION} installed successfully!"
  echo "Launch from Applications or use: open /Applications/${APP_NAME}"
  echo ""
  echo "To uninstall:"
  echo "  sudo rm -rf ${APPS_DIR}/${APP_NAME}"
fi

