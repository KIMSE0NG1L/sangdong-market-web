const { Pool } = require('pg');

const pool = new Pool({
  host: process.env.DB_HOST,
  port: process.env.DB_PORT,
  database: process.env.DB_NAME,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
});

// 연결 테스트
pool.on('connect', () => {
  console.log('PostgreSQL 데이터베이스 연결 성공');
});

pool.on('error', (err) => {
  console.error('PostgreSQL 연결 오류:', err);
  process.exit(-1);
});

module.exports = pool;