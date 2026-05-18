---
heartbeat: 60
triggers:
  - port.change
on_tick:
  - check_uptime
  - submit_status_tile
---

# Tick Schedule

Every 60 seconds submits a status tile to PLATO.

