# Guion de video (≤ 5 min)

1) **Introducción (20s)**
   - Nombre del proyecto y objetivo: desplegar una app Node + Express en EC2 y añadir CI con GitHub Actions.

2) **Antes (30s)**
   - Mostrar el repo sin `.github/workflows/` y sin badge.
   - Abrir la app local (npm start) o la IP pública sin Nginx (si aplica).

3) **Despliegue en EC2 (90s)**
   - Mostrar la instancia EC2 (tipo, SG con puertos 22 y 80 abiertos).
   - SSH a la instancia (una línea).
   - Ejecutar: `bash scripts/ec2-ubuntu-setup.sh <user> <repo>`
   - Abrir la IP pública en el navegador: app funcionando.
   - Explicar en 1 frase Nginx reverse proxy y systemd service.

4) **Automatización con GitHub Actions (90s)**
   - Mostrar `ci.yml`.
   - Hacer un cambio mínimo (README) y `git commit && git push`.
   - Abrir la pestaña **Actions**: pipeline corriendo → verde.
   - Mostrar el badge en el README y explicar qué valida (tests + estructura).

5) **Después (30s)**
   - Comparar: antes no había validaciones/automatización; ahora sí.
   - Beneficios: calidad, rapidez, confianza.

6) **Cierre (20s)**
   - Aprendizajes y recomendación final.