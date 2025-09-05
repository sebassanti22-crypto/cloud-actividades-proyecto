

![CI](https://github.com/sebassanti22-crypto/cloud-actividades-proyecto/actions/workflows/ci.yml/badge.svg)

Proyecto base para **Actividad 1 (Despliegue en AWS EC2)** y **Actividad 2 (Automatización con GitHub Actions)**.

---

## 📦 Tecnologías
- Node.js 18 + Express
- Frontend estático (HTML + JS)
- PokéAPI (API pública) para ejemplo de consumo externo
- Nginx como reverse proxy en EC2
- GitHub Actions (Jest + Supertest) para validaciones

---

## 📁 Estructura
```
.
├── README.md
├── package.json
├── .gitignore
├── public/
│   └── index.html
├── src/
│   ├── app.js
│   └── server.js
├── tests/
│   └── basic.test.js
├── .github/
│   └── workflows/
│       └── ci.yml
└── scripts/
    └── ec2-ubuntu-setup.sh
```


---

## 🧪 Scripts
- `npm start` — Inicia el servidor en `http://localhost:3000`
- `npm test` — Ejecuta Jest + Supertest

---

## 🚀 Actividad 1: Despliegue en AWS EC2 (resumen)
1. **Crear Instancia EC2** (Ubuntu 22.04 LTS, t2.micro/t3.micro) y **Key Pair (.pem)**.
2. **Security Group**: abrir puertos 22 (SSH) y 80 (HTTP).
3. **Clonar repo y preparar servidor**
   - SSH: `ssh -i <tu.pem> ubuntu@<IP-EC2>`
   - `sudo apt update && sudo apt install -y git`
   - Copia el repo o usa el script:
     ```bash
   
4. **Servicio y reverse proxy**
   - `systemctl status cloudapp` → activo
   - Nginx sirve la app en `http://<IP-EC2>/`
5. **Verificación**
   - Frontend carga, prueba un nombre (ej: `pikachu`)
   - `/api/ping` responde `{ ok: true }`
.


---

## 🤖 Actividad 2: Automatización con GitHub Actions (resumen)
- Workflow: `.github/workflows/ci.yml`
  - Corre en `push` a `main` y en PRs.
  - Instala Node 18, dependencias, verifica estructura y ejecuta tests.
- **Badge en README**: ya incluido (ajusta la URL).
- **Tests**: `tests/basic.test.js` prueba `/api/ping` y un test matemático.

### Instrucciones
1. **Habilitar Actions**: primer `git push` a `main`.
2. Ver **pestaña Actions**: pipeline debe pasar en verde.
3. Agrega capturas del pipeline funcionando y (si hubo) errores + solución.
4. Explica brevemente qué se automatizó y beneficios.



