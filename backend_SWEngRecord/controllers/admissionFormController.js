const { getConnection } = require('../db');

// Student: submit admission form (create)
exports.submitForm = async (req, res) => {
  const db = getConnection();
  const studentId = req.user.id; // from authMiddleware

  const {
    discipline,
    roll_no,
    full_name,
    cnic,
    dob,
    religion,
    nationality,
    district,
    urban_rural,
    present_address,
    permanent_address,
    telephone,
    student_cell,
    email,
    matric_marks,
    matric_board,
    matric_year,
    matric_grade,
    inter_marks,
    inter_board,
    inter_year,
    inter_grade,
    guardian_name,
    guardian_relation,
    guardian_occupation,
    guardian_designation,
    guardian_org_address,
    guardian_tel_off,
    guardian_tel_res,
    guardian_cell,
    guardian_annual_income
  } = req.body;

  // Minimal validation (add more if you want)
  if (!discipline || !roll_no || !full_name || !cnic) {
    return res.status(400).json({ message: 'discipline, roll_no, full_name, cnic are required.' });
  }

  try {
    // enforce role (middleware already does it, this is defensive)
    const [user] = await db.execute('SELECT role FROM Users WHERE id = ?', [studentId]);
    if (!user.length || user[0].role !== 'student') {
      return res.status(403).json({ message: 'Only students can submit forms.' });
    }

    // Optional: prevent duplicate (if you didn't add unique index on student_id)
    const [exists] = await db.execute('SELECT id FROM AdmissionForms WHERE student_id = ?', [studentId]);
    if (exists.length) {
      return res.status(409).json({ message: 'Form already exists for this student. Use update endpoint.' });
    }

    await db.execute(
      `INSERT INTO AdmissionForms
        (student_id, discipline, roll_no, full_name, cnic, dob, religion, nationality, district, urban_rural,
         present_address, permanent_address, telephone, student_cell, email,
         matric_marks, matric_board, matric_year, matric_grade,
         inter_marks, inter_board, inter_year, inter_grade,
         guardian_name, guardian_relation, guardian_occupation, guardian_designation,
         guardian_org_address, guardian_tel_off, guardian_tel_res, guardian_cell, guardian_annual_income)
       VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`,
      [
        studentId, discipline, roll_no, full_name, cnic, dob, religion, nationality, district, urban_rural,
        present_address, permanent_address, telephone, student_cell, email,
        matric_marks, matric_board, matric_year, matric_grade,
        inter_marks, inter_board, inter_year, inter_grade,
        guardian_name, guardian_relation, guardian_occupation, guardian_designation,
        guardian_org_address, guardian_tel_off, guardian_tel_res, guardian_cell, guardian_annual_income
      ]
    );

    return res.status(201).json({ message: 'Admission form submitted successfully.' });
  } catch (err) {
    console.error('Submit Form Error:', err);
    return res.status(500).json({ message: 'Server error' });
  }
};

// Student: view own form
exports.getMyForm = async (req, res) => {
  const db = getConnection();
  try {
    const [rows] = await db.execute(
      'SELECT * FROM AdmissionForms WHERE student_id = ? ORDER BY created_at DESC LIMIT 1',
      [req.user.id]
    );
    if (!rows.length) return res.status(404).json({ message: 'Form not found.' });
    res.json(rows[0]);
  } catch (err) {
    console.error('Get My Form Error:', err);
    res.status(500).json({ message: 'Server error' });
  }
};

// Clerk: view all forms
exports.getAllForms = async (req, res) => {
  const db = getConnection();
  try {
    const [forms] = await db.execute(
      `SELECT sf.*, u.name AS user_name, u.email AS user_email
       FROM AdmissionForms sf
       JOIN Users u ON sf.student_id = u.id
       ORDER BY sf.created_at DESC`
    );
    res.json(forms);
  } catch (err) {
    console.error('Get All Forms Error:', err);
    res.status(500).json({ message: 'Server error' });
  }
};

// Clerk: update a form (whitelisted fields only)
// exports.updateForm = async (req, res) => {
//   const db = getConnection();
//   const { form_id } = req.params;

//   // whitelist to avoid updating protected columns
//   const allowed = new Set([
//     'discipline','roll_no','full_name','cnic','dob','religion','nationality','district','urban_rural',
//     'present_address','permanent_address','telephone','student_cell','email',
//     'matric_marks','matric_board','matric_year','matric_grade',
//     'inter_marks','inter_board','inter_year','inter_grade',
//     'guardian_name','guardian_relation','guardian_occupation','guardian_designation',
//     'guardian_org_address','guardian_tel_off','guardian_tel_res','guardian_cell','guardian_annual_income',
//     'student_signature','chairman_signature'
//   ]);

//   const entries = Object.entries(req.body).filter(([k]) => allowed.has(k));
//   if (!entries.length) return res.status(400).json({ message: 'No valid fields provided.' });

//   const setSql = entries.map(([k]) => `${k} = ?`).join(', ');
//   const values = entries.map(([,v]) => v);

//   try {
//     const [result] = await db.execute(`UPDATE AdmissionForms SET ${setSql} WHERE id = ?`, [...values, form_id]);
//     if (result.affectedRows === 0) return res.status(404).json({ message: 'Form not found.' });
//     res.json({ message: 'Form updated successfully.' });
//   } catch (err) {
//     console.error('Update Form Error:', err);
//     res.status(500).json({ message: 'Server error' });
//   }
// };
exports.updateForm = async (req, res) => {
  const db = getConnection();
  const { form_id } = req.params;

  if (!req.body || Object.keys(req.body).length === 0) {
    return res.status(400).json({ message: 'Request body is missing or empty.' });
  }

  const allowed = new Set([
    'discipline','roll_no','full_name','cnic','dob','religion','nationality','district','urban_rural',
    'present_address','permanent_address','telephone','student_cell','email',
    'matric_marks','matric_board','matric_year','matric_grade',
    'inter_marks','inter_board','inter_year','inter_grade',
    'guardian_name','guardian_relation','guardian_occupation','guardian_designation',
    'guardian_org_address','guardian_tel_off','guardian_tel_res','guardian_cell','guardian_annual_income',
    'student_signature','chairman_signature'
  ]);

  const entries = Object.entries(req.body).filter(([k]) => allowed.has(k));
  if (!entries.length) return res.status(400).json({ message: 'No valid fields provided.' });

  const setSql = entries.map(([k]) => `${k} = ?`).join(', ');
  const values = entries.map(([, v]) => v);

  try {
    const [result] = await db.execute(
      `UPDATE AdmissionForms SET ${setSql} WHERE id = ?`,
      [...values, form_id]
    );
    if (result.affectedRows === 0) return res.status(404).json({ message: 'Form not found.' });
    res.json({ message: 'Form updated successfully.' });
  } catch (err) {
    console.error('Update Form Error:', err);
    res.status(500).json({ message: 'Server error' });
  }
};

// Clerk: delete a form
exports.deleteForm = async (req, res) => {
  const db = getConnection();
  const { form_id } = req.params;
  try {
    const [result] = await db.execute('DELETE FROM AdmissionForms WHERE id = ?', [form_id]);
    if (result.affectedRows === 0) return res.status(404).json({ message: 'Form not found.' });
    res.json({ message: 'Form deleted successfully.' });
  } catch (err) {
    console.error('Delete Form Error:', err);
    res.status(500).json({ message: 'Server error' });
  }
};
