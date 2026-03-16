When plugging in a USB-C cable carrying power, display, and USB
devices (keyboard and mouse via a monitor's internal hub), the
keyboard and mouse were unresponsive. The root cause was that the
monitor's built-in USB hub is dependent on the display connection
being active — the hub only becomes operational once the external
monitor is enabled by the OS. Since the display output was not yet
enabled, the hub had no active host to enumerate its downstream
devices, leaving the keyboard and mouse non-functional until the
monitor was brought online first.
