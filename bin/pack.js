'use strict';

const { execSync } = require('child_process');
const path = require('path');

// Detect platform from environment or use current platform
const platform = process.env.TARGET_PLATFORM || process.platform;

// Map platform names to electron-builder format
const platformMap = {
  'darwin': 'mac',
  'macos': 'mac',
  'linux': 'linux',
  'win32': 'win',
  'windows': 'win'
};

const targetPlatform = platformMap[platform] || platform;

console.log(`Building Medis for platform: ${targetPlatform}`);

try {
  // Build the project first
  console.log('Running webpack build...');
  execSync('npm run build', { stdio: 'inherit' });

  // Run electron-builder with the specified platform
  console.log(`Packaging for ${targetPlatform}...`);
  const buildCommand = `npx electron-builder --${targetPlatform}`;
  execSync(buildCommand, { stdio: 'inherit' });

  console.log(`\n✓ Build complete for ${targetPlatform}!`);
  console.log('Output directory: dist/');
} catch (error) {
  console.error('Build failed:', error.message);
  process.exit(1);
}
