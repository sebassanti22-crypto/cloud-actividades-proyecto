import request from 'supertest';
import app from '../src/app.js';

describe('CI smoke tests', () => {
  it('GET /api/ping -> 200 {ok:true}', async () => {
    const res = await request(app).get('/api/ping');
    expect(res.status).toBe(200);
    expect(res.body).toEqual({ ok: true });
  });
});
