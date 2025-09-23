// const express = require('express');
// const router = express.Router();

// const marksController = require('../controllers/marksController');
// const authMiddleware = require('../middleware/authMiddleware');
// const roleMiddleware = require('../middleware/roleMiddleware');

// // Clerk: Add or Update marks (insert if new, update if exists)
// router.post(
//   '/add',
//   authMiddleware,
//   roleMiddleware('clerk'),
//   marksController.addMarks
// );

// // Clerk: Update marks (by record ID)
// router.put(
//   '/update/:id',
//   authMiddleware,
//   roleMiddleware('clerk'),
//   marksController.updateMarks
// );

// // Clerk: Delete marks
// router.delete(
//   '/delete/:id',
//   authMiddleware,
//   roleMiddleware('clerk'),
//   marksController.deleteMarks
// );

// // Both Clerk and Student: View all marks
// router.get(
//   '/all',
//   authMiddleware,
//   marksController.getAllMarks
// );

// // Both Clerk and Student: Filter by roll number
// router.get(
//   '/roll/:roll_no',
//   authMiddleware,
//   marksController.getMarksByRollNo
// );

// // Both Clerk and Student: Filter by semester
// router.get(
//   '/semester/:semester',
//   authMiddleware,
//   marksController.getMarksBySemester
// );

// module.exports = router;


const express = require('express');
const router = express.Router();
const marksController = require('../controllers/marksController');
const authMiddleware = require('../middleware/authMiddleware');
const roleMiddleware = require('../middleware/roleMiddleware');

// Clerk: add marks
router.post(
  '/add',
  authMiddleware,
  roleMiddleware('clerk'),
  marksController.addMarks
);

// Clerk: update marks
router.put(
  '/:marks_id',
  authMiddleware,
  roleMiddleware('clerk'),
  marksController.updateMarks
);

// Clerk: delete marks
router.delete(
  '/:marks_id',
  authMiddleware,
  roleMiddleware('clerk'),
  marksController.deleteMarks
);

// Clerk: filter by roll number
router.get(
  '/roll/:roll_no',
  authMiddleware,
  roleMiddleware('clerk'),
  marksController.getMarksByRollNo
);

// Clerk: view all marks
router.get(
  '/all',
  authMiddleware,
  roleMiddleware('clerk'),
  marksController.getAllMarks
);

// Student: view own marks
router.get(
  '/my',
  authMiddleware,
  roleMiddleware('student'),
  marksController.getMyMarks
);

module.exports = router;
