const express = require('express');
const router = express.Router();

const admissionFormController = require('../controllers/admissionFormController');
const authMiddleware = require('../middleware/authMiddleware');
const roleMiddleware = require('../middleware/roleMiddleware');

// Student: submit form
router.post(
  '/submit',
  authMiddleware,
  roleMiddleware('student'),
  admissionFormController.submitForm
);

// Student: view own form
router.get(
  '/my',
  authMiddleware,
  roleMiddleware('student'),
  admissionFormController.getMyForm
);

// Clerk: view all forms
router.get(
  '/all',
  authMiddleware,
  roleMiddleware('clerk'),
  admissionFormController.getAllForms
);

// Clerk: update a form
router.put(
  '/:form_id',
  authMiddleware,
  roleMiddleware('clerk'),
  admissionFormController.updateForm
);

// Clerk: delete a form
router.delete(
  '/:form_id',
  authMiddleware,
  roleMiddleware('clerk'),
  admissionFormController.deleteForm
);

module.exports = router;

