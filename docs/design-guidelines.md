# Medis Design Guidelines

## Overview

This document outlines the design guidelines, UI/UX patterns, and component design principles for the Medis Redis GUI application. These guidelines ensure consistency, usability, and a professional appearance across the application.

## Design Philosophy

### Core Principles

1. **Simplicity**: Keep the interface clean and uncluttered
2. **Consistency**: Maintain consistent design patterns throughout
3. **Functionality**: Prioritize functionality and user needs
4. **Accessibility**: Ensure the application is accessible to all users
5. **Performance**: Optimize for fast and responsive interactions

### User Experience Goals

- **Intuitive Navigation**: Users should easily find and use features
- **Efficient Workflow**: Minimize steps for common tasks
- **Clear Feedback**: Provide clear and timely feedback
- **Error Prevention**: Design to prevent user errors
- **Flexibility**: Support different user preferences and workflows

## Color Scheme

### Primary Colors

- **Primary**: `#2c3e50` (Dark Blue) - Main background and primary elements
- **Secondary**: `#3498db` (Blue) - Accent colors and highlights
- **Success**: `#27ae60` (Green) - Success states and positive feedback
- **Warning**: `#f39c12` (Orange) - Warning states and attention
- **Danger**: `#e74c3c` (Red) - Error states and critical actions
- **Info**: `#3498db` (Blue) - Informational states

### Background Colors

- **Background**: `#f8f9fa` (Light Gray) - Main background
- **Surface**: `#ffffff` (White) - Card and panel backgrounds
- **Dark Mode**: `#1a1a1a` (Dark) - Dark mode background

### Text Colors

- **Primary Text**: `#212529` (Dark Gray) - Main text
- **Secondary Text**: `#6c757d` (Gray) - Secondary text
- **Muted Text**: `#adb5bd` (Light Gray) - Muted or disabled text
- **Link Text**: `#3498db` (Blue) - Links and interactive text

## Typography

### Font Family

- **Primary**: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif
- **Monospace**: 'Fira Code', 'Courier New', monospace (for code and terminal)

### Font Sizes

- **Heading 1**: 24px / 1.5rem
- **Heading 2**: 20px / 1.25rem  
- **Heading 3**: 18px / 1.125rem
- **Body**: 14px / 1rem
- **Small**: 12px / 0.75rem
- **Code**: 13px / 0.8125rem

### Font Weights

- **Regular**: 400
- **Medium**: 500
- **Semibold**: 600
- **Bold**: 700

## Layout and Spacing

### Grid System

- **Container Width**: 1200px max-width
- **Gutter**: 16px horizontal spacing
- **Column Width**: 12-column grid system
- **Breakpoints**: Mobile (≤768px), Tablet (768-1024px), Desktop (≥1024px)

### Spacing Scale

- **Extra Small**: 4px
- **Small**: 8px
- **Medium**: 16px
- **Large**: 24px
- **Extra Large**: 32px
- **Huge**: 48px

### Padding and Margins

- **Container Padding**: 16px
- **Card Padding**: 16px
- **Button Padding**: 8px 16px
- **Input Padding**: 8px 12px

## Component Design

### Buttons

#### Primary Button

```jsx
<button className="btn btn-primary">
  Primary Action
</button>
```

- **Background**: `#3498db`
- **Text**: White
- **Border**: None
- **Hover**: `#2980b9`
- **Active**: `#2471a3`

#### Secondary Button

```jsx
<button className="btn btn-secondary">
  Secondary Action
</button>
```

- **Background**: Transparent
- **Text**: `#3498db`
- **Border**: `#3498db` 1px solid
- **Hover**: `#2980b9`
- **Active**: `#2471a3`

#### Success Button

```jsx
<button className="btn btn-success">
  Success Action
</button>
```

- **Background**: `#27ae60`
- **Text**: White
- **Border**: None
- **Hover**: `#229954`
- **Active**: `#1e8449`

#### Warning Button

```jsx
<button className="btn btn-warning">
  Warning Action
</button>
```

- **Background**: `#f39c12`
- **Text**: White
- **Border**: None
- **Hover**: `#e67e22`
- **Active**: `#d35400`

#### Danger Button

```jsx
<button className="btn btn-danger">
  Danger Action
</button>
```

- **Background**: `#e74c3c`
- **Text**: White
- **Border**: None
- **Hover**: `#c0392b`
- **Active**: `#a93226`

#### Button Sizes

- **Small**: `btn-sm` - 8px 12px padding
- **Medium**: `btn-md` - 8px 16px padding (default)
- **Large**: `btn-lg` - 12px 24px padding

### Inputs

#### Text Input

```jsx
<input 
  type="text" 
  className="form-control" 
  placeholder="Enter text"
/>
```

- **Background**: White
- **Border**: `#ced4da` 1px solid
- **Focus**: `#3498db` border and outline
- **Padding**: 8px 12px
- **Border Radius**: 4px

#### Select Input

```jsx
<select className="form-select">
  <option>Select option</option>
</select>
```

- **Background**: White
- **Border**: `#ced4da` 1px solid
- **Focus**: `#3498db` border and outline
- **Padding**: 8px 12px
- **Border Radius**: 4px

#### Textarea

```jsx
<textarea 
  className="form-control" 
  rows="3"
  placeholder="Enter text"
></textarea>
```

- **Background**: White
- **Border**: `#ced4da` 1px solid
- **Focus**: `#3498db` border and outline
- **Padding**: 8px 12px
- **Border Radius**: 4px

### Cards

```jsx
<div className="card">
  <div className="card-header">
    Card Title
  </div>
  <div className="card-body">
    Card Content
  </div>
</div>
```

- **Background**: White
- **Border**: `#dee2e6` 1px solid
- **Border Radius**: 4px
- **Shadow**: Small shadow for depth
- **Margin**: 16px bottom

### Navigation

#### Sidebar Navigation

```jsx
<nav className="sidebar">
  <ul className="sidebar-nav">
    <li className="nav-item">
      <a className="nav-link active" href="#">Home</a>
    </li>
    <li className="nav-item">
      <a className="nav-link" href="#">Connections</a>
    </li>
  </ul>
</nav>
```

- **Background**: `#2c3e50`
- **Text**: White
- **Active**: `#3498db` background
- **Hover**: `#34495e` background

#### Top Navigation

```jsx
<nav className="navbar">
  <div className="navbar-brand">Medis</div>
  <div className="navbar-menu">
    <a className="nav-link" href="#">Connections</a>
    <a className="nav-link" href="#">Settings</a>
  </div>
</nav>
```

- **Background**: White
- **Border Bottom**: `#dee2e6` 1px solid
- **Text**: `#212529`
- **Active**: `#3498db` text and border

## UI Patterns

### Connection Management

#### Connection List

```jsx
<div className="connection-list">
  {connections.map(connection => (
    <ConnectionItem 
      key={connection.id} 
      connection={connection}
      isActive={connection.id === activeConnectionId}
      onSelect={handleSelectConnection}
    />
  ))}
</div>
```

- **Item Background**: White
- **Active Item**: `#e9ecef` background
- **Hover**: `#f8f9fa` background
- **Border**: `#dee2e6` 1px solid
- **Border Radius**: 4px

#### Connection Form

```jsx
<form className="connection-form">
  <div className="form-group">
    <label>Host</label>
    <input 
      type="text" 
      className="form-control"
      value={host}
      onChange={handleHostChange}
    />
  </div>
  <div className="form-group">
    <label>Port</label>
    <input 
      type="number" 
      className="form-control"
      value={port}
      onChange={handlePortChange}
    />
  </div>
  <div className="form-actions">
    <button className="btn btn-primary">Connect</button>
    <button className="btn btn-secondary">Cancel</button>
  </div>
</form>
```

- **Form Group**: 16px bottom margin
- **Label**: `#495057` text
- **Input**: `#212529` text
- **Error**: `#e74c3c` text and border

### Key Management

#### Key Browser

```jsx
<div className="key-browser">
  <KeySearch onSearch={handleSearch} />
  <KeyList 
    keys={keys}
    onSelect={handleSelectKey}
    onEdit={handleEditKey}
  />
</div>
```

- **Search Bar**: Full width, 16px bottom margin
- **Key List**: Grid or list layout
- **Key Item**: Hover effect, selection state
- **Empty State**: Clear message with action button

#### Key Details

```jsx
<div className="key-details">
  <KeyHeader key={key} />
  <KeyValue value={value} type={type} />
  <KeyActions onEdit={handleEdit} onDelete={handleDelete} />
</div>
```

- **Header**: Key name and type
- **Value**: Formatted display based on type
- **Actions**: Edit and delete buttons

### Terminal

#### Terminal Component

```jsx
<Terminal 
  prompt="medis> "
  onCommand={handleCommand}
  history={commandHistory}
/>
```

- **Background**: `#1a1a1a` (dark)
- **Text**: `#f8f8f2` (light)
- **Prompt**: `#50fa7b` (green)
- **Command**: `#f8f8f2` (light)
- **Output**: `#8be9fd` (cyan) for results

### Pattern Manager

#### Pattern List

```jsx
<div className="pattern-manager">
  <PatternInput onAdd={handleAddPattern} />
  <PatternList 
    patterns={patterns}
    onEdit={handleEditPattern}
    onDelete={handleDeletePattern}
  />
</div>
```

- **Input**: Full width, 16px bottom margin
- **Pattern Item**: Tag-style display
- **Add Button**: Primary action button

## Responsive Design

### Breakpoints

- **Mobile**: ≤768px
- **Tablet**: 768-1024px
- **Desktop**: ≥1024px

### Mobile-First Approach

- Design for mobile first
- Scale up for larger screens
- Use flexible layouts
- Optimize touch interactions

### Desktop Enhancements

- Additional information
- Advanced controls
- Multiple columns
- Keyboard shortcuts

## Accessibility

### Color Contrast

- **Text on Background**: Minimum 4.5:1 contrast ratio
- **Interactive Elements**: Clear hover and focus states
- **Error States**: High contrast for error messages

### Keyboard Navigation

- **Tab Order**: Logical and sequential
- **Focus Indicators**: Clear and visible
- **Shortcut Keys**: Consistent and documented
- **ARIA Labels**: Proper accessibility labels

### Screen Readers

- **Semantic HTML**: Use proper HTML elements
- **ARIA Attributes**: Add ARIA attributes where needed
- **Dynamic Content**: Announce changes to screen readers
- **Form Labels**: Associate labels with inputs

## Dark Mode

### Color Scheme for Dark Mode

- **Background**: `#1a1a1a`
- **Surface**: `#2d2d2d`
- **Text**: `#f8f8f2`
- **Muted Text**: `#b0b0b0`
- **Primary**: `#3498db`
- **Success**: `#27ae60`
- **Warning**: `#f39c12`
- **Danger**: `#e74c3c`

### Implementation

```jsx
const [darkMode, setDarkMode] = useState(false);

// Apply dark mode class
<div className={darkMode ? 'dark-mode' : ''}>
  {/* Content */}
</div>
```

## Animation and Transitions

### Transition Duration

- **Fast**: 150ms
- **Normal**: 300ms
- **Slow**: 500ms

### Transition Properties

- **Opacity**: 300ms ease-in-out
- **Transform**: 300ms ease-in-out
- **Background**: 300ms ease-in-out
- **Border**: 300ms ease-in-out

### Animation Examples

#### Button Hover

```css
.btn {
  transition: background 300ms ease-in-out, color 300ms ease-in-out;
}

.btn:hover {
  background: #2980b9;
  color: white;
}
```

#### Modal Fade

```css
.modal {
  opacity: 0;
  transition: opacity 300ms ease-in-out;
}

.modal.show {
  opacity: 1;
}
```

## Iconography

### Icon Usage

- **Font Awesome**: Primary icon set
- **Custom Icons**: For application-specific icons
- **Size**: 16px, 20px, 24px based on context

### Icon Colors

- **Primary**: `#212529`
- **Secondary**: `#6c757d`
- **Success**: `#27ae60`
- **Warning**: `#f39c12`
- **Danger**: `#e74c3c`

## Error Handling

### Error States

#### Form Errors

```jsx
<div className="form-group">
  <label>Host</label>
  <input 
    type="text" 
    className="form-control is-invalid"
    value={host}
    onChange={handleHostChange}
  />
  <div className="invalid-feedback">
    Please enter a valid host
  </div>
</div>
```

- **Invalid State**: Red border and background
- **Error Message**: Red text, 8px top margin
- **Validation**: Real-time validation

#### Connection Errors

```jsx
<ConnectionStatus 
  status={connectionStatus}
  error={connectionError}
  onRetry={handleRetry}
/>
```

- **Error Display**: Clear error message
- **Retry Button**: Primary action button
- **Timeout**: Auto-retry with delay

## Loading States

### Loading Indicators

```jsx
<LoadingSpinner size="md" />
```

- **Size**: Small (16px), Medium (24px), Large (32px)
- **Color**: `#3498db` primary
- **Background**: Transparent or light

### Content Loading

```jsx
<div className="content-loader">
  <LoadingSpinner />
  <p>Loading data...</p>
</div>
```

- **Full Screen**: Centered loading state
- **Partial**: Inline loading indicator
- **Skeleton**: Placeholder content while loading

## User Feedback

### Success Messages

```jsx
<Alert type="success">
  Connection successful!
</Alert>
```

- **Background**: `#d4edda`
- **Border**: `#c3e6cb`
- **Text**: `#155724`
- **Icon**: Checkmark icon

### Warning Messages

```jsx
<Alert type="warning">
  Connection may be slow
</Alert>
```

- **Background**: `#fff3cd`
- **Border**: `#ffeeba`
- **Text**: `#856404`
- **Icon**: Warning icon

### Error Messages

```jsx
<Alert type="error">
  Connection failed
</Alert>
```

- **Background**: `#f8d7da`
- **Border**: `#f5c6cb`
- **Text**: `#721c24`
- **Icon**: Error icon

## Component Library

### Reusable Components

1. **Buttons**: Primary, secondary, success, warning, danger
2. **Inputs**: Text, select, textarea, checkbox, radio
3. **Cards**: Content containers with headers and bodies
4. **Navigation**: Sidebar, top nav, breadcrumbs
5. **Alerts**: Success, warning, error, info
6. **Loaders**: Spinners and skeleton loaders
7. **Modals**: Dialog boxes and overlays
8. **Tables**: Data tables with sorting and filtering
9. **Forms**: Form groups and validation
10. **Icons**: Icon components and utilities

### Component Documentation

Each component should have:
- **Props**: Input properties and types
- **Examples**: Usage examples
- **Styling**: CSS classes and customization
- **Accessibility**: ARIA attributes and keyboard support

## Design System Maintenance

### Version Control

- **Version**: Semantic versioning (major.minor.patch)
- **Changes**: Document breaking changes
- **Migration**: Provide migration guides

### Documentation

- **Component Docs**: Detailed component documentation
- **Style Guide**: Visual style guide
- **Usage Examples**: Common use cases

### Testing

- **Visual Regression**: Automated visual testing
- **Accessibility Testing**: Automated accessibility checks
- **Cross-Browser Testing**: Support for multiple browsers

This design guidelines document provides a comprehensive framework for maintaining consistent, accessible, and user-friendly design across the Medis Redis GUI application. Following these guidelines ensures a professional appearance and optimal user experience.