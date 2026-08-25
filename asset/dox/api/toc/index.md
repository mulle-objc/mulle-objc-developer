# mulle-objc-developer Library Documentation for AI

## 1. Introduction & Purpose

**mulle-objc-developer** is a mulle-sde developer kit that provides development tools, build extensions, and utilities for developing and debugging mulle-objc projects.

**Key Features:**
- mulle-sde build system extensions
- Development tool integration
- Build environment configuration
- Not a runtime library; purely development/build time
- Part of mulle-sde ecosystem tooling

**When to Use:**
- Adding to development environments for mulle-objc work
- Setting up build systems for mulle-objc projects
- Accessing development tools and configurations

**What It Provides:**
- Environment variables and build settings
- Script utilities for developers
- mulle-sde extension points
- Debugging and inspection tools

## 2. Key Concepts & Design Philosophy

- **Build Time Only**: No runtime component
- **Extension Model**: Extends mulle-sde with mulle-objc-specific behavior
- **Environment Configuration**: Provides shell scripts for build environment setup
- **Developer-Focused**: Tools and utilities for developers, not applications
- **Composable**: Works with other developer kits

## 3. Core API & Data Structures

### 3.1 Build System Integration

**Type**: mulle-sde Developer Kit (not a traditional library)

**Installation Location**: `share/mulle-sde/` and configuration files

**Environment Variables Provided**:
- Build flags for mulle-objc projects
- Compiler settings
- Path configurations

### 3.2 Provided Extensions

#### mulle-sde Environment Scripts

Files in `.mulle/share/env/`:
- `environment.sh` - Main environment setup
- `environment-extension.sh` - Extension configuration
- `environment-plugin.sh` - Plugin support
- `environment-plugin-os-darwin.sh` - macOS-specific configuration

**Purpose**: Configure mulle-sde build environment for mulle-objc development

**Usage**: Automatically sourced by mulle-sde during project setup

### 3.3 Developer Tools

**Access**: Via mulle-sde commands when kit is active

**Examples**:
- Enhanced build configuration
- Project templates for mulle-objc
- Development utilities

## 4. Performance Characteristics

**Not Applicable** - Build configuration only; no runtime performance

**Build-Time Impact**: Minimal—configuration file loading and variable setup

## 5. AI Usage Recommendations & Patterns

### Best Practices

- **Project Setup**: Add mulle-objc-developer early in project initialization
- **Integration**: Works automatically once added; no code needed
- **Versioning**: Pin to stable releases for reproducibility

### Common Pitfalls

- **Platform-Specific**: Some features OS-specific (e.g., Darwin plugin)
- **Dependency Order**: Add before other development kits if both needed
- **Removal**: Removing mid-project may require rebuild

### Idiomatic Usage

**Pattern 1: Adding to Project**
```bash
mulle-sde add --github mulle-objc mulle-objc-developer
mulle-sde craft
```

**Pattern 2: Using Enhanced Build Tools**
```bash
# With mulle-objc-developer installed, builds have enhanced configuration
mulle-sde craft  # Uses mulle-objc-optimized settings
mulle-sde run    # Environment pre-configured
```

## 6. Integration Examples

### Example 1: Project Setup with Development Kit

```bash
# Initialize new mulle-objc project
mulle-sde init -d MulleObjC myproject
cd myproject

# Add development kit for building
mulle-sde add --github mulle-objc mulle-objc-developer

# Now builds use mulle-objc-developer settings
mulle-sde craft
```

### Example 2: Environment Configuration Access

```bash
# After adding mulle-objc-developer, shell environment configured automatically
# Scripts in .mulle/share/env/ are sourced

# Developers can access:
source .mulle/share/env/environment.sh
echo $COBJC  # mulle-clang (set by configuration)
```

## 7. Dependencies

**None** - This is a pure development configuration kit

**Works With**:
- mulle-sde (build system)
- mulle-objc-cc (compiler configuration)
- Other developer kits (foundation-developer, etc.)

**Not a Traditional Library** - No code dependencies or linkage
