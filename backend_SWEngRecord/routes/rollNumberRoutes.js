const express = require('express');
const router = express.Router();
const controller = require('../controllers/rollNumberController');
const authMiddleware = require('../middleware/authMiddleware');
const roleMiddleware = require('../middleware/roleMiddleware');

// Create new student - Clerk only
router.post(
  '/',
  authMiddleware,
  roleMiddleware('clerk'),
  controller.createStudent
);

// Get roll number list - both roles
router.get(
  '/',
  authMiddleware,
  controller.getList
);

// Update student - Clerk only
router.put(
  '/:id',
  authMiddleware,
  roleMiddleware('clerk'),
  controller.updateStudent
);

// Delete student - Clerk only
router.delete(
  '/:id',
  authMiddleware,
  roleMiddleware('clerk'),
  controller.deleteStudent
);

module.exports = router;
