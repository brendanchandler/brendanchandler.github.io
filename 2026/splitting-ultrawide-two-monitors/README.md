# Splitting an Ultrawide Monitor into Two Virtual Monitors

Split a 3440x1440 ultrawide (DP-1) into two 1720x1440 virtual monitors using
`xrandr --setmonitor` on X11. The laptop display (eDP-1, 1920x1080) is unaffected.

## Setup

| Output | Resolution | Role |
|--------|-----------|------|
| DP-1   | 3440x1440 | Ultrawide external monitor (the one being split) |
| eDP-1  | 1920x1080 | Laptop built-in display |

## Usage

```bash
# Toggle split on/off (default)
./toggle-split.sh

# Explicitly split into two virtual monitors
./toggle-split.sh split

# Restore to a single monitor
./toggle-split.sh restore
```

## How It Works

`xrandr --setmonitor` creates named virtual monitor regions that the window
manager treats as separate screens for snapping, fullscreen, taskbars, etc.

**Split state** — two virtual monitors replace DP-1:
```
DP-1-left   1720x1440 at offset 0,0
DP-1-right  1720x1440 at offset 1720,0
```

**Restored state** — the virtual monitors are deleted and xrandr reverts DP-1
to its original single-monitor representation automatically.

Verify the current state at any time:
```bash
xrandr --listmonitors
```

## Persistent Setup

To apply the split automatically on login, call the script from your display
session startup file:

```bash
# ~/.xprofile  (most display managers)
~/.local/bin/toggle-split.sh split

# or ~/.xinitrc  (startx / xinit)
~/.local/bin/toggle-split.sh split &
```

Or add it as an autostart `.desktop` entry in `~/.config/autostart/`.
