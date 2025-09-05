# Lista de capturas sugeridas

- Instancia EC2 creada (tipo t2.micro/t3.micro, Ubuntu 22.04).
- Security Group con puertos 22 (SSH) y 80 (HTTP) abiertos.
- Conexión SSH exitosa (terminal).
- Ejecución del script `scripts/ec2-ubuntu-setup.sh` sin errores.
- `systemctl status cloudapp` en verde.
- `sudo nginx -t` OK y Nginx recargado.
- App funcionando en `http://IP-EC2/` mostrando la UI y respuesta de la API.
- En GitHub: pestaña **Actions** con workflow exitoso.
- Badge visible en el README (en rama `main`).

> Agrega también capturas de errores (si ocurrieron) y cómo los resolviste.