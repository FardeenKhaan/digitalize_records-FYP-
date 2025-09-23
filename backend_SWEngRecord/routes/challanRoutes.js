const express = require('express');
const router = express.Router();
const challanController = require('../controllers/challanController');
const auth = require('../middleware/authMiddleware');
const role = require('../middleware/roleMiddleware');
const upload = require('../middleware/uploadMiddleware'); // <— NEW

// Student uploads challan + image (mandatory)
router.post(
  '/upload',
  auth,
  role('student'),
  upload.single('image'),            // <— NEW: field name = "image"
  challanController.uploadChallan
);

// Clerk views pending
router.get('/pending', auth, role('clerk'), challanController.getPendingChallans);

// Clerk verifies / rejects
router.put('/status/:challan_id', auth, role('clerk'), challanController.updateChallanStatus);

// Student views own challans
router.get('/my', auth, role('student'), challanController.getStudentChallans);

// Clerk views all challans
router.get('/all', auth, role('clerk'), challanController.getAllChallans);

module.exports = router;
