
const path = require('path'); // upload image of challan
const express = require('express');
const dotenv = require('dotenv');
const cors = require('cors');
// const bodyParser = require("body-parser");

dotenv.config(); // Load env vars

const { connectDB } = require('./db');
const authRoutes = require('./routes/authRoutes');
const challanRoutes = require('./routes/challanRoutes');
const announcementRoutes = require('./routes/announcementRoutes');
const rollNumberRoutes = require('./routes/rollNumberRoutes');
const admissionFormRoutes = require('./routes/admissionFormRoutes');
const marksRoutes = require('./routes/marksRoutes');
const app = express();

// Middlewares
app.use(cors());
app.use(express.json());
// app.use(bodyParser.urlencoded({ extended: true }));

// Health check route
app.get('/', (req, res) => {
  res.send('API is running...');
});

// Routes
app.use('/api/auth', authRoutes);

app.use('/api/challans', challanRoutes);

// after app initialization and before routes:
app.use('/uploads', express.static(path.join(__dirname, 'uploads')));

app.use('/api/announcements', announcementRoutes);

app.use('/api/rollnumbers', rollNumberRoutes);

app.use('/api/forms', admissionFormRoutes);

app.use('/api/marks', marksRoutes);

// DB connection and server start
connectDB()
  .then(() => {
    const PORT = process.env.PORT || 3000;
    app.listen(PORT, () => {
      console.log(`🚀 Server running on port ${PORT}`);
    });
  })
  .catch(err => {
    console.error('❌ Could not connect to DB:', err);
  });
