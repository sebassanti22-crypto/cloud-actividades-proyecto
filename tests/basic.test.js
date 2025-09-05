import request from 'supertest';
import app from '../src/app.js';

describe('Pruebas básicas', () => {
  test('1 + 1 = 2', () => {
    expect(1 + 1).toBe(2);
  });

  test('GET /api/ping retorna ok:true', async () => {
    const res = await request(app).get('/api/ping');
    expect(res.status).toBe(200);
    expect(res.body.ok).toBe(true);
  });
});