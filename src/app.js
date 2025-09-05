import express from 'express';
import path from 'path';
import { fileURLToPath } from 'url';
import fetch from 'node-fetch';

const app = express();
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// Servir frontend estático
app.use(express.static(path.join(__dirname, '..', 'public')));

// Endpoint simple para pruebas
app.get('/api/ping', (req, res) => res.json({ ok: true }));

// Endpoint que consume PokéAPI
app.get('/api/pokemon/:name', async (req, res) => {
  try {
    const name = String(req.params.name || '').toLowerCase();
    const resp = await fetch(`https://pokeapi.co/api/v2/pokemon/${encodeURIComponent(name)}`);
    if (!resp.ok) return res.status(resp.status).json({ error: 'not_found', status: resp.status });
    const data = await resp.json();
    res.json({
      name: data.name,
      id: data.id,
      height: data.height,
      weight: data.weight
    });
  } catch (err) {
    res.status(500).json({ error: 'fetch_failed' });
  }
});

// Endpoints de salud para Nginx/systemd
app.get('/health', (_req, res) => res.send('OK'));
app.get('/ready', (_req, res) => res.send('READY'));

export default app;