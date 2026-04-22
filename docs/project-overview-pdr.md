# Medis - Redis GUI Application

## Project Overview

Medis is a beautiful, easy-to-use Redis management application built on the modern web with Electron, React, and Redux. It's powered by many awesome Node.js modules, especially ioredis and ssh2.

### Purpose

Medis provides a graphical user interface for managing Redis databases, offering an intuitive way to interact with Redis data, execute commands, and manage connections. It's designed to work with Redis >= 2.8 version and supports advanced features like JSON/MessagePack format viewing, SSH tunneling, and pattern-based key selection.

### Key Features

- **Keys Management**: View, edit, and manage Redis keys with support for various data types
- **SSH Tunneling**: Secure connections to remote Redis servers via SSH
- **Integrated Terminal**: Execute custom Redis commands directly
- **Config Management**: View and edit Redis configuration
- **Advanced Features**:
  - JSON/MessagePack format viewing and editing with built-in highlighting
  - Pattern manager for easy key selection
  - Support for millions of keys without blocking the Redis server
  - Built-in validator for JSON/MessagePack data

### Technical Stack

- **Frontend**: React 16.8.6, Redux 4.0.1, React-Redux 7.0.3
- **Desktop**: Electron 4.2.2, ioredis 4.9.3, ssh2 0.8.9
- **Build**: Webpack 4.31.0, TypeScript 3.4.5, Babel 7.4.4
- **UI**: jQuery Terminal, xterm, fixed-data-table-contextmenu

## Product Development Requirements (PDR)

### Functional Requirements

1. **Connection Management**
   - Support multiple Redis instances
   - SSH tunneling for secure connections
   - Connection persistence and management
   - Heroku Redis integration

2. **Data Management**
   - Keys viewing and editing
   - Support for various Redis data types
   - JSON/MessagePack format handling
   - Pattern-based key selection

3. **Command Execution**
   - Integrated terminal for custom commands
   - Command history and auto-completion
   - Command validation and error handling

4. **User Interface**
   - Responsive design
   - Dark mode support
   - Intuitive navigation
   - Keyboard shortcuts

### Non-Functional Requirements

1. **Performance**
   - Handle millions of keys without blocking
   - Fast response times for key operations
   - Efficient memory usage

2. **Security**
   - Secure connection handling
   - Data encryption for SSH tunnels
   - Input validation and sanitization

3. **Usability**
   - Intuitive user interface
   - Clear error messages
   - Comprehensive documentation
   - Cross-platform compatibility

4. **Maintainability**
   - Modular architecture
   - Clear code structure
   - Comprehensive testing
   - Version control and release management

### Acceptance Criteria

- Application launches successfully on all supported platforms
- All Redis commands execute correctly
- SSH tunnel connections work as expected
- JSON/MessagePack data formats display and edit properly
- Pattern manager functions correctly
- Application handles large datasets efficiently
- All UI components render and function as expected

### Technical Constraints

- Must support Redis >= 2.8 (SCAN command required)
- Must work with Electron 4.2.2
- Must be compatible with Node.js LTS versions
- Must maintain backward compatibility with existing Redis features

### Success Metrics

- User adoption rate and feedback
- Application stability and crash-free usage
- Performance benchmarks for large datasets
- Security audit results
- Code coverage and test pass rates
- Community contributions and engagement

### Version History

- **v1.0.3**: Current stable release with core Redis management features
- **v2.0**: Major rewrite with native technology, tree view, dark mode, and enhanced features

### License

MIT License - Free and open source software

### Contact Information

- Project Repository: https://github.com/luin/medis
- Author: luin <i@zihua.li>
- Website: https://getmedis.com/