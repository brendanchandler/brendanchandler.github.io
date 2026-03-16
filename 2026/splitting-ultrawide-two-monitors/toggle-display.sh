#!/usr/bin/env bash
# toggle-split.sh — Split DP-1 (3440x1440 ultrawide) into two virtual monitors,
# or restore it to a single monitor. Toggled by checking current monitor names.

BUILTIN_MONITOR="eDP-1"
WIDE_EXT_MONITOR="DP-1"
LEFT="DP-1-left"
RIGHT="DP-1-right"

# Full width of the ultrawide, split evenly
FULL_W=3440
HALF_W=1720
HEIGHT=1440
HALF_W_MM=400   # physical mm for each half (~800mm total / 2)
HEIGHT_MM=335   # physical mm height

is_wide_external() {
    xrandr --listmonitors | grep -q "$LEFT"
}

wide_external() {
    echo "Splitting $WIDE_EXT_MONITOR into $LEFT and $RIGHT..."
    xrandr --delmonitor "$WIDE_EXT_MONITOR" 2>/dev/null || true
    xrandr --setmonitor "$LEFT"  "${HALF_W}/${HALF_W_MM}x${HEIGHT}/${HEIGHT_MM}+0+0" "$WIDE_EXT_MONITOR"
    xrandr --setmonitor "$RIGHT" "${HALF_W}/${HALF_W_MM}x${HEIGHT}/${HEIGHT_MM}+${HALF_W}+0" none
    xrandr --output $BUILTIN_MONITOR --off
    echo "Done. Run 'xrandr --listmonitors' to verify."
}

builtin_only() {
    echo "Restoring $WIDE_EXT_MONITOR as a single monitor..."
    xrandr --output $BUILTIN_MONITOR --auto
    xrandr --delmonitor "$LEFT"  2>/dev/null || true
    xrandr --delmonitor "$RIGHT" 2>/dev/null || true
    echo "Done. Run 'xrandr --listmonitors' to verify."
}


if is_wide_external; then
    builtin_only
else
    wide_external
fi

