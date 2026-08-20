# Minimal Dot Workspace

Minimalist dot-style workspace indicators for the [Omarchy](https://omarchy.org/) shell bar.

## Install

```bash
cd ~/.config/omarchy/plugins
git clone https://github.com/YOUR_USER/minimal-dot-workspace.git minimal.dot.workspace
```

Then add to your `~/.config/omarchy/shell.json` bar layout:

```json
"left": [
  {
    "id": "minimal.dot.workspace"
  }
]
```

## Features

- Dynamic workspace count (1-5 default, expands up to 10 as you open new workspaces)

## Requirements

- Omarchy Quattro
