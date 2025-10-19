# 🎨 Wallpaper Collection

A curated collection of beautiful wallpapers organized by themes and styles.

## 📁 Structure

```
wallpaper/
├── walls/                    # Main wallpaper collection
│   ├── abstract/            # Abstract art and designs
│   ├── anime/               # Anime and manga wallpapers
│   ├── nature/              # Natural landscapes and scenery
│   ├── nord/                # Nord-themed wallpapers
│   ├── minimal/             # Minimalist designs
│   ├── retro/               # Retro and vintage styles
│   ├── digital/             # Digital art and renders
│   ├── animated/            # Animated wallpapers (GIFs/MP4s)
│   └── ...                  # Many more categories!
└── README.md                # This file
```

## 🚀 Getting Started

### Option 1: Download from Source
The wallpapers are sourced from [dharmx/walls](https://github.com/dharmx/walls) - a fantastic collection of high-quality wallpapers.

```bash
# Clone the original repository
git clone https://github.com/dharmx/walls.git

# Copy wallpapers to your collection
cp -r walls/* /path/to/your/wallpaper/walls/
```

### Option 2: Manual Download
Visit the [GitHub repository](https://github.com/dharmx/walls) and download individual wallpapers or entire categories that interest you.

### Option 3: Use Wallpaper Scripts
Create scripts to automatically download and organize wallpapers:

```bash
#!/bin/bash
# Example wallpaper downloader script
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
mkdir -p "$WALLPAPER_DIR"

# Download specific categories
curl -L "https://api.github.com/repos/dharmx/walls/contents/abstract" | \
  jq -r '.[].download_url' | \
  xargs -I {} wget -P "$WALLPAPER_DIR/abstract/" {}
```

## 🎯 Categories Overview

| Category | Description | Count |
|----------|-------------|-------|
| **Abstract** | Geometric patterns, artistic designs | 40+ |
| **Anime** | Anime characters, scenes, and artwork | 200+ |
| **Nature** | Landscapes, forests, mountains, water | 60+ |
| **Nord** | Nord color scheme themed wallpapers | 150+ |
| **Minimal** | Clean, simple, minimalist designs | 50+ |
| **Retro** | Vintage, nostalgic, retro aesthetics | 25+ |
| **Digital** | Digital art, renders, computer graphics | 50+ |
| **Animated** | Moving wallpapers (GIFs/MP4s) | 15+ |

## 🔧 Usage Tips

### Setting Wallpapers on macOS
```bash
# Set a specific wallpaper
osascript -e 'tell application "System Events" to tell every desktop to set picture to "/path/to/wallpaper.jpg"'

# Random wallpaper from a category
WALLPAPER=$(find wallpaper/walls/nature -name "*.jpg" -o -name "*.png" | shuf -n 1)
osascript -e "tell application \"System Events\" to tell every desktop to set picture to \"$WALLPAPER\""
```

### Using with Wallpaper Managers
- **Wallpaper Engine** (Steam) - For animated wallpapers
- **Dynamic Wallpaper** - For time-based wallpapers
- **Wallpaper Wizard** - For automatic rotation

## 📝 Notes

- **File Formats**: Most wallpapers are in JPG/PNG format
- **Resolutions**: Various resolutions available, many in 4K
- **Animated**: Some categories include animated wallpapers (GIF/MP4)
- **Organization**: Wallpapers are organized by theme/style for easy browsing