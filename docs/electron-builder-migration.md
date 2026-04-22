# Electron Builder Migration Guide

## Overview

Medis has been migrated from `electron-packager` to `electron-builder` for better cross-platform support, especially for Linux/Ubuntu builds.

## Changes Made

### 1. Dependencies Updated

- Added `electron-builder@22.14.13` to devDependencies
- Added `sass@1.32.13` to replace deprecated `node-sass`
- Updated webpack configuration to use modern sass implementation

### 2. Build Scripts Updated

All build scripts now include `NODE_OPTIONS="--openssl-legacy-provider"` for Node.js 17+ compatibility:

```bash
# Build for development
npm run build

# Package for current platform
npm run pack

# Package for specific platforms
npm run pack:linux   # Linux (AppImage, DEB, tar.gz)
npm run pack:mac     # macOS (DMG, ZIP)
npm run pack:win     # Windows (NSIS, ZIP)
```

### 3. Configuration Added

Added `build` configuration to `package.json`:
- Multi-platform targets (Linux, macOS, Windows)
- AppImage support for Linux
- DEB package support for Ubuntu/Debian
- DMG support for macOS
- NSIS installer support for Windows

## Building on Ubuntu/Linux

### Prerequisites

```bash
# Install build tools
sudo apt-get update
sudo apt-get install -y build-essential libssl-dev

# Install Node.js (if not already installed)
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs
```

### Build Steps

1. **Clone and install dependencies:**
```bash
git clone https://github.com/luin/medis.git
cd medis
npm install --legacy-peer-deps
```

2. **Build the application:**
```bash
npm run build
```

3. **Package for Linux:**
```bash
npm run pack:linux
```

This will create:
- `Medis-1.0.3.AppImage` - Universal Linux package
- `medis_1.0.3_amd64.deb` - Debian/Ubuntu package
- `medis-1.0.3-linux-x64.tar.gz` - Tarball archive

### Installing on Ubuntu

**Option 1: Install Script (Recommended - Auto-detects latest)**
```bash
# Install latest version from your fork
curl -fsSL https://raw.githubusercontent.com/haipham22/medis/master/install-medis.sh | bash

# Or install specific version
VERSION=v1.0.3 curl -fsSL https://raw.githubusercontent.com/haipham22/medis/master/install-medis.sh | bash

# Or use original upstream releases
REPO=luin/medis curl -fsSL https://raw.githubusercontent.com/haipham22/medis/master/install-medis.sh | bash
```

**Option 2: AppImage (Direct download)**
```bash
# Download latest
wget https://github.com/haipham22/medis/releases/latest/download/Medis-*.AppImage
chmod +x Medis-*.AppImage
./Medis-*.AppImage
```

**Option 3: Tarball**
```bash
tar -xzf medis-1.0.3-linux-x64.tar.gz
cd medis-linux-x64/
./medis
```

## Troubleshooting

### Node.js Version Issues

If you encounter OpenSSL errors, the build scripts automatically use `--openssl-legacy-provider`. For Node.js 17+:

```bash
NODE_OPTIONS="--openssl-legacy-provider" npm run build
```

### Sass Build Errors

The project now uses `sass` instead of deprecated `node-sass`. If you encounter sass errors:

```bash
npm install --save-dev sass@1.32.13 --legacy-peer-deps
```

### Permission Issues on Linux

If the AppImage doesn't run:
```bash
chmod +x Medis-*.AppImage
./Medis-*.AppImage
```

If you get "Permission denied" errors:
```bash
./Medis-*.AppImage --appimage-extract
./squashfs-root/AppRun
```

### Missing Dependencies on Ubuntu

If the DEB package fails to install:
```bash
sudo apt-get install -f -y
```

## Migration from electron-packager

The old `bin/pack.js` script has been updated to use electron-builder. The main differences:

### Before (electron-packager):
```bash
node bin/pack.js  # Only worked for macOS
```

### After (electron-builder):
```bash
npm run pack          # Builds for current platform
npm run pack:linux    # Explicit Linux build
npm run pack:mac      # Explicit macOS build
npm run pack:win      # Explicit Windows build
```

## Build Outputs

| Platform | Output Location | Formats |
|----------|----------------|---------|
| Linux | `dist/` | AppImage, DEB, tar.gz |
| macOS | `dist/` | DMG, ZIP |
| Windows | `dist/` | NSIS installer, ZIP |

## Additional Resources

- [electron-builder Documentation](https://www.electron.build/)
- [AppImage Documentation](https://docs.appimage.org/)
- [Electron Linux Builds](https://www.electronjs.org/docs/tutorial/code-signing#linux)
