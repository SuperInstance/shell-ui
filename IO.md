---
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
    schema:
      domain: web
      question: shell-ui status
      answer: JSON with status and metrics
pulls:
  - name: config
    source: plato
    room: config/shell-ui
    interval: 3600
---

