const mysql = require('mysql2/promise');
require('dotenv').config();

let pool;

async function connectDB() {
  try {
    pool = await mysql.createPool({
      host: process.env.SQL_HOST,
      user: process.env.SQL_USER,
      password: process.env.SQL_PASSWORD,
      database: process.env.SQL_DATABASE,
      waitForConnections: true,
      connectionLimit: 10,
      queueLimit: 0
    });
    console.log('✅ Connected to MySQL');
  } catch (err) {
    console.error('❌ MySQL connection error:', err);
    throw err; // propagate error to server.js
  }
}

function getConnection() {
  return pool;
}

module.exports = {
  connectDB,
  getConnection
};
