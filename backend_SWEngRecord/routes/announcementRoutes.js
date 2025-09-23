const express = require('express');
const router = express.Router();
const controller = require('../controllers/announcementController');
const authMiddleware = require('../middleware/authMiddleware');
const roleMiddleware = require('../middleware/roleMiddleware');

router.post(
  '/create',
  authMiddleware,
  roleMiddleware('clerk'),
  controller.createAnnouncement
);

router.get(
  '/',
  authMiddleware,
  controller.getAnnouncements
);

router.put(
  '/:id',
  authMiddleware,
  roleMiddleware('clerk'),
  controller.updateAnnouncement
);

router.delete(
  '/:id',
  authMiddleware,
  roleMiddleware('clerk'),
  controller.deleteAnnouncement
);

module.exports = router;

