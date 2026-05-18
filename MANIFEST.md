---
name: shell-ui
family: web
version: 0.1.0
summary: "The fleet browser-based work surface — shell, filesystem, fleet health. Single-page web interface for the Terax Gateway. Zero build step."
provides:
  - tool_name: shell-ui_serve
    description: Serve the web interface
  - tool_name: shell-ui_build
    description: Build for production
depends_on:
  - service: plato
    port: 8847
    required: false
    reason: Optional PLATO integration
ticks:
  heartbeat: 60
  triggers: [port.change]
io:
  sensors:
    - name: port-8400-input
      type: http
      port: 8400
      description: Service endpoint
    - name: port-8847-input
      type: http
      port: 8847
      description: Service endpoint
    - name: port-8900-input
      type: http
      port: 8900
      description: Service endpoint
  pushes:
    - name: knowledge-tile
      dest: plato
      type: tile
      domain: web
      interval: 3600
      question: shell-ui status
  pulls:
    - name: config
      source: plato
      room: config/shell-ui
      interval: 3600
---

