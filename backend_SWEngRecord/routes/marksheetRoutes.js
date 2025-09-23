const express = require('express');
const router = express.Router();
const authMiddleware = require('../middleware/authMiddleware');
const roleMiddleware = require('../middleware/roleMiddleware'); 

// Clerk uploads a marksheet
router.post(
  '/upload',
  authMiddleware,              // Must be logged in
  roleMiddleware('clerk'),     // Must be a clerk
  (req, res) => {
    res.send("Marksheet uploaded by clerk");
  }
);

module.exports = router;
