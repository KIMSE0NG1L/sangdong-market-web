require('dotenv').config();
const express = require('express');
const pool = require('./src/config/database');

const app = express();

// 미들웨어
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// DB 연결 테스트 라우트
app.get('/db-test', async (req, res) => {
  try {
    const result = await pool.query('SELECT NOW()');
    res.json({ 
      success: true, 
      message: 'DB 연결 성공!',
      time: result.rows[0].now 
    });
  } catch (error) {
    res.status(500).json({ 
      success: false, 
      error: error.message 
    });
  }
});

// 기본 라우트
app.get('/', (req, res) => {
  res.json({ message: '상동시장 백엔드 서버' });
});

// 서버 시작
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`서버가 포트 ${PORT}번에서 실행중입니다.`);
});