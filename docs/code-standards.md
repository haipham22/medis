# Medis Code Standards and Best Practices

## Overview

This document outlines the coding standards, best practices, and conventions used throughout the Medis codebase. Following these standards ensures code consistency, maintainability, and quality across the project.

## General Guidelines

### File Structure

- **File Naming**: Use kebab-case for JavaScript/TypeScript files (e.g., `file-name.ts`)
- **Directory Structure**: Organize files by functionality, not by type
- **File Size**: Keep individual files under 200 lines for optimal context management
- **Import Order**: Group imports by type (external, internal, local)

### Code Organization

- **Single Responsibility**: Each file should have one clear purpose
- **Modular Design**: Break down complex components into smaller, reusable modules
- **Clear Separation**: Maintain separation between main process and renderer process code
- **Consistent Architecture**: Follow established architectural patterns

## JavaScript/TypeScript Standards

### Syntax and Formatting

```typescript
// Use strict mode
'use strict';

// Use arrow functions for anonymous functions
const handleClick = () => {
  // function body
};

// Use const for variables that don't change
const MAX_RETRIES = 3;

// Use let for variables that may change
let attempts = 0;

// Use descriptive variable names
const userName = 'john';
const userId = 123;

// Use descriptive function names
function calculateTotalPrice(items) {
  // implementation
}

// Use consistent indentation (2 spaces)
if (condition) {
  // code block
}

// Use semicolons
const value = 42;
```

### Type Safety

```typescript
// Use TypeScript interfaces for data structures
interface RedisInstance {
  host: string;
  port: number;
  password?: string;
  sshTunnel?: boolean;
}

// Use type annotations
function connectToRedis(instance: RedisInstance): Promise<void> {
  // implementation
}

// Use enums for fixed sets of values
enum ConnectionStatus {
  CONNECTING,
  CONNECTED,
  DISCONNECTED,
  ERROR
}

// Use generics where appropriate
function filterArray<T>(array: T[], predicate: (item: T) => boolean): T[] {
  return array.filter(predicate);
}
```

### Error Handling

```typescript
// Use try-catch for error-prone operations
try {
  await redisClient.connect();
} catch (error) {
  console.error('Connection failed:', error);
  throw new Error('Failed to connect to Redis');
}

// Create custom error types
class RedisConnectionError extends Error {
  constructor(message: string) {
    super(message);
    this.name = 'RedisConnectionError';
  }
}

// Use proper error propagation
function executeCommand(command: string): Promise<any> {
  try {
    return redisClient.execute(command);
  } catch (error) {
    throw new RedisConnectionError(`Command failed: ${command}`);
  }
}
```

### Asynchronous Code

```typescript
// Use async/await for asynchronous operations
async function fetchKeys(pattern: string): Promise<string[]> {
  const keys = await redisClient.keys(pattern);
  return keys;
}

// Handle multiple async operations
async function initializeApp(): Promise<void> {
  try {
    await connectToRedis();
    await loadFavorites();
    await setupUI();
  } catch (error) {
    console.error('Initialization failed:', error);
  }
}

// Use Promise.all for parallel operations
async function loadMultipleInstances(): Promise<void> {
  const instances = await Promise.all([
    loadInstance('primary'),
    loadInstance('secondary')
  ]);
}
```

## React and Redux Standards

### Component Structure

```typescript
// Use functional components with hooks
import React, { useState, useEffect } from 'react';

interface KeyBrowserProps {
  instanceId: string;
}

const KeyBrowser: React.FC<KeyBrowserProps> = ({ instanceId }) => {
  const [keys, setKeys] = useState<string[]>([]);
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    loadKeys();
  }, [instanceId]);

  const loadKeys = async () => {
    setLoading(true);
    try {
      const fetchedKeys = await fetchKeys(instanceId);
      setKeys(fetchedKeys);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="key-browser">
      {/* component content */}
    </div>
  );
};

export default KeyBrowser;
```

### Redux Patterns

```typescript
// Use Redux Toolkit for modern Redux patterns
import { createSlice, PayloadAction } from '@reduxjs/toolkit';

interface InstanceState {
  instances: RedisInstance[];
  activeInstanceId: string | null;
}

const initialState: InstanceState = {
  instances: [],
  activeInstanceId: null
};

const instanceSlice = createSlice({
  name: 'instances',
  initialState,
  reducers: {
    addInstance: (state, action: PayloadAction<RedisInstance>) => {
      state.instances.push(action.payload);
    },
    setActiveInstance: (state, action: PayloadAction<string>) => {
      state.activeInstanceId = action.payload;
    }
  }
});

export const { addInstance, setActiveInstance } = instanceSlice.actions;
export default instanceSlice.reducer;
```

### State Management

- **Immutable State**: Always return new state objects, never mutate existing state
- **Selector Functions**: Use reselect for efficient state selection
- **Action Creators**: Create clear and descriptive action types
- **Middleware**: Use middleware for side effects (e.g., logging, async operations)

## Electron-Specific Standards

### Main Process

```typescript
// Main process entry point
import { app, BrowserWindow } from 'electron';

function createWindow(): void {
  const mainWindow = new BrowserWindow({
    width: 800,
    height: 600,
    webPreferences: {
      nodeIntegration: false,
      contextIsolation: true,
      preload: path.join(__dirname, 'preload.js')
    }
  });

  mainWindow.loadFile('index.html');
}

app.whenReady().then(createWindow);
```

### IPC Communication

```typescript
// Main process - handle IPC messages
import { ipcMain } from 'electron';

ipcMain.handle('redis-command', async (event, command: string) => {
  try {
    const result = await executeRedisCommand(command);
    return { success: true, data: result };
  } catch (error) {
    return { success: false, error: error.message };
  }
});

// Renderer process - send IPC messages
const result = await window.electronAPI.redisCommand('GET mykey');
```

## Testing Standards

### Unit Tests

```typescript
// Use Jest for testing
import { render, screen } from '@testing-library/react';
import KeyBrowser from './KeyBrowser';

describe('KeyBrowser Component', () => {
  test('renders key list', () => {
    render(<KeyBrowser instanceId="test" />);
    const keyElement = screen.getByText('test-key');
    expect(keyElement).toBeInTheDocument();
  });
});
```

### Test Coverage

- Aim for 80%+ test coverage
- Test both success and error scenarios
- Mock external dependencies
- Use test doubles for complex components

## Code Review Guidelines

### Review Checklist

- [ ] Code follows established standards
- [ ] Proper error handling and edge cases
- [ ] Meaningful variable and function names
- [ ] Adequate comments and documentation
- [ ] Test coverage and test quality
- [ ] Performance considerations
- [ ] Security implications
- [ ] Accessibility compliance

### Commenting Standards

- Use JSDoc for public APIs and complex functions
- Explain "why" not "what" in comments
- Keep comments up-to-date with code changes
- Use TODO comments for planned improvements

```typescript
/**
 * Connects to Redis instance with retry logic
 * @param instance - Redis instance configuration
 * @param maxRetries - Maximum number of connection attempts
 * @returns Promise that resolves when connected
 */
async function connectWithRetry(instance: RedisInstance, maxRetries: number): Promise<void> {
  // implementation
}
```

## Performance Best Practices

### Optimization Techniques

- **Memoization**: Use React.memo and useMemo for expensive calculations
- **Lazy Loading**: Implement code splitting for large components
- **Virtualization**: Use virtualized lists for large datasets
- **Debouncing**: Debounce input handlers for better performance
- **Web Workers**: Offload heavy computations to web workers

### Memory Management

- Avoid memory leaks by cleaning up event listeners
- Use proper disposal of resources (database connections, file handles)
- Implement proper garbage collection patterns
- Monitor memory usage and optimize when necessary

## Security Best Practices

### Input Validation

- Validate all user inputs
- Sanitize data before processing
- Use parameterized queries for database operations
- Implement proper authentication and authorization

### Secure Coding

- Use HTTPS for all network communications
- Implement proper error handling without exposing sensitive information
- Use secure storage for credentials
- Follow the principle of least privilege

## Contribution Guidelines

### Branching Strategy

- **main**: Production-ready code
- **develop**: Development branch
- **feature/xxx**: Feature branches
- **hotfix/xxx**: Hotfix branches

### Commit Messages

- Use conventional commit format
- Be descriptive and clear
- Include relevant issue numbers
- Follow commit message conventions

```bash
feat: Add new Redis command support
fix: Resolve connection timeout issue
docs: Update API documentation
refactor: Improve component structure
test: Add unit tests for key management
chore: Update dependencies
```

### Pull Request Process

1. Create feature branch from develop
2. Implement changes following coding standards
3. Write comprehensive tests
4. Update documentation
5. Submit pull request with clear description
6. Address review comments
7. Merge to develop after approval

## Tools and Utilities

### Linting

- Use ESLint for JavaScript/TypeScript linting
- Configure rules for code consistency
- Run linting before commits

### Formatting

- Use Prettier for code formatting
- Configure consistent formatting rules
- Run formatting before commits

### Type Checking

- Use TypeScript for type safety
- Configure tsconfig for project requirements
- Run type checking during development

## Maintenance Guidelines

### Dependency Management

- Regularly update dependencies
- Test updates thoroughly
- Monitor for security vulnerabilities
- Follow semantic versioning

### Documentation

- Keep documentation up-to-date
- Document breaking changes
- Provide migration guides when needed
- Maintain API documentation

### Monitoring and Logging

- Implement proper logging
- Monitor application performance
- Track errors and exceptions
- Use analytics for user behavior

This code standards document serves as a guide for all developers working on the Medis project. Adherence to these standards ensures code quality, maintainability, and consistency across the codebase.