# Medis Deployment Guide

## Overview

This guide provides detailed instructions for building, packaging, and deploying the Medis Redis GUI application. The deployment process involves several steps including setting up the development environment, building the application, and creating distributable packages for different platforms.

## Prerequisites

### System Requirements

- **Node.js**: v12.0.0 or higher
- **npm**: v6.0.0 or higher
- **Git**: v2.0.0 or higher
- **Python**: v3.6 or higher (for Electron Packager)
- **Electron**: v4.2.2 (as specified in package.json)
- **Build Tools**: Platform-specific build tools

### Platform-Specific Requirements

#### macOS
- Xcode Command Line Tools
- macOS 10.10 or higher

#### Windows
- Visual Studio Build Tools
- Windows 10 or higher

#### Linux
- Build essentials (gcc, make, etc.)
- Linux distribution with desktop environment

## Development Environment Setup

### Step 1: Clone the Repository

```bash
git clone https://github.com/luin/medis.git
cd medis
```

### Step 2: Install Dependencies

```bash
npm install
```

### Step 3: Verify Installation

```bash
npm run build
npm start
```

## Build Process

### Build Configuration

The build process is configured in `webpack.config.js` and uses Webpack for bundling the application.

### Build Scripts

#### Development Build

```bash
npm run build
```

This command:
- Cleans the `dist` directory
- Bundles the application using Webpack
- Outputs the built files to `dist/`

#### Watch Mode (Development)

```bash
npm run watch
```

This command:
- Starts Webpack in watch mode
- Automatically rebuilds on file changes
- Useful for development

#### Production Build

```bash
npm run pack
```

This command:
- Builds the application
- Packages it for distribution
- Creates distributable files

## Packaging for Distribution

### Packaging Configuration

The packaging process is handled by `bin/pack.js` and uses Electron Packager for creating distributable packages.

### Packaging Scripts

#### macOS Packaging

```bash
npm run pack
```

This creates:
- `medis-darwin-x64` directory with macOS package
- `medis-1.0.3.dmg` disk image (if configured)

#### Windows Packaging

```bash
npm run pack -- --platform=win32 --arch=x64
```

This creates:
- `medis-win32-x64` directory with Windows package
- `Medis Setup 1.0.3.exe` installer

#### Linux Packaging

```bash
npm run pack:linux
```

This creates:
- `Medis-1.0.3.AppImage` - Universal Linux package (150MB)
- `medis-1.0.3.tar.gz` - Tarball archive (129MB)
- `linux-unpacked/` directory with unpacked application

### Custom Packaging Options

```bash
npm run pack \
  -- --platform=win32 \
  --arch=x64 \
  --icon=assets/icon.ico \
  --version=1.0.3 \
  --out=build-output
```

## Platform-Specific Deployment

### macOS Deployment

#### Prerequisites
- Xcode Command Line Tools
- Code signing certificate
- Notarization service

#### Build and Package

```bash
npm run pack
```

#### Code Signing

```bash
codesign --force --deep --sign "Developer ID Application: Your Name (Team ID)" \
  --options runtime \
  --entitlements electron-builder.entitlements \
  dist/mac/medis.app
```

#### Notarization

```bash
xcrun notarytool submit dist/mac/medis.app --keychain-profile "AC_PASSWORD" --wait
```

### Windows Deployment

#### Prerequisites
- Visual Studio Build Tools
- Code signing certificate
- Windows SDK

#### Build and Package

```bash
npm run pack -- --platform=win32 --arch=x64
```

#### Code Signing

```bash
signtool sign /a /f certificate.pfx /p password \
  /t http://timestamp.digicert.com \
  dist/win32-x64/medis Setup 1.0.3.exe
```

### Linux Deployment

#### Prerequisites
- Build essentials
- Desktop environment
- Package manager

#### Build and Package

```bash
npm run pack -- --platform=linux --arch=x64
```

#### Create DEB Package (Ubuntu/Debian)

```bash
cd dist/linux-x64
mkdir -p DEBIAN
cat > DEBIAN/control << EOF
Package: medis
Version: 1.0.3
Section: utils
Priority: optional
Architecture: amd64
Maintainer: Medis Team <team@medis.com>
Description: Redis GUI Application
EOF

dpkg-deb --build medis-1.0.3_amd64
```

#### Create RPM Package (Fedora/CentOS)

```bash
cd dist/linux-x64
mkdir -p SPECS
cat > SPECS/medis.spec << EOF
Name: medis
Version: 1.0.3
Release: 1
Summary: Redis GUI Application
License: MIT
EOF

rpmbuild -bb SPECS/medis.spec
```

## Release Process

### Version Management

#### Update Version

1. Update `package.json` version
2. Update `CHANGELOG.md`
3. Commit version changes

```bash
npm version patch  # or minor, major
git push --tags
```

### Build Release

```bash
npm run pack
```

### Publish to GitHub Releases

1. Create new release on GitHub
2. Upload packaged files
3. Add release notes
4. Publish release

### Distribute to Users

- **macOS**: Distribute via GitHub Releases or App Store
- **Windows**: Distribute via GitHub Releases or Microsoft Store
- **Linux**: Distribute via package repositories or GitHub Releases

## CI/CD Pipeline

### GitHub Actions Configuration

```yaml
name: Build and Release Medis

on:
  push:
    tags:
      - 'v*.*.*'

jobs:
  build:
    runs-on: ${{ matrix.os }}
    strategy:
      matrix:
        os: [macos-latest, windows-latest, ubuntu-latest]
        arch: [x64]
    
    steps:
    - uses: actions/checkout@v2
    - name: Setup Node.js
      uses: actions/setup-node@v2
      with:
        node-version: 14
    - name: Install dependencies
      run: npm install
    - name: Build application
      run: npm run pack
    - name: Upload artifacts
      uses: actions/upload-artifact@v2
      with:
        name: medis-${{ matrix.os }}-${{ matrix.arch }}
        path: dist/
```

### Automated Testing

```bash
npm test
```

This runs the test suite to ensure code quality before release.

## Troubleshooting

### Common Build Issues

#### Node.js Version Mismatch

```bash
# Check Node.js version
node -v

# Use nvm to manage Node.js versions
nvm use 14
```

#### Missing Dependencies

```bash
npm install
npm rebuild
```

#### Build Failures

```bash
# Clean build directory
rm -rf dist/
npm run build

# Check for specific errors in build logs
npm run pack -- --verbose
```

### Packaging Issues

#### Code Signing Failures

```bash
# Verify certificate
codesign -vv --deep dist/mac/medis.app

# Re-sign application
codesign --force --deep --sign "Developer ID Application: Your Name" dist/mac/medis.app
```

#### Platform-Specific Errors

- **macOS**: Ensure Xcode Command Line Tools are installed
- **Windows**: Ensure Visual Studio Build Tools are installed
- **Linux**: Ensure build essentials are installed

## Best Practices

### Environment Variables

Use environment variables for sensitive information:

```bash
export ELECTRON_CACHE=/path/to/cache
export ELECTRON_BUILDER_CACHE=/path/to/builder-cache
```

### Cache Management

```bash
# Clear cache before building
npm run clean

# Use cache for faster builds
npm config set cache /path/to/npm-cache
```

### Version Consistency

- Keep Electron version consistent with package.json
- Test with multiple Node.js versions
- Maintain backward compatibility

### Security Considerations

- Use code signing for distribution
- Regularly update dependencies
- Perform security audits
- Use HTTPS for all network communications

## Support and Resources

### Documentation

- [Official Documentation](https://getmedis.com/docs)
- [GitHub Wiki](https://github.com/luin/medis/wiki)
- [README.md](https://github.com/luin/medis/blob/master/README.md)

### Community Support

- [GitHub Issues](https://github.com/luin/medis/issues)
- [Discord/Slack](https://discord.gg/medis)
- [Stack Overflow](https://stackoverflow.com/questions/tagged/medis)

### Commercial Support

- [Medis 2 on App Store](https://apps.apple.com/us/app/medis-2-gui-for-redis/id1579200037)
- [Official Website](https://getmedis.com/)

This deployment guide provides comprehensive instructions for building and distributing the Medis Redis GUI application across multiple platforms, ensuring a smooth release process and high-quality user experience.