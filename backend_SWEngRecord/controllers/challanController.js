// const { getConnection } = require('../db');

// // Student Upload Challan
// exports.uploadChallan = async (req, res) => {
//   const db = getConnection();

//   const {
//     roll_no,
//     name,
//     father_name,
//     semester_year,
//     challan_no,
//     submission_date,
//     fees_amount
//   } = req.body;

//   try {
//     const [user] = await db.execute(
//       'SELECT * FROM Users WHERE id = ?',
//       [req.user.id]
//     );

//     if (!user.length || user[0].role !== 'student') {
//       return res.status(403).json({ message: 'Only students can upload challans.' });
//     }

//     await db.execute(
//       `INSERT INTO Challans 
//         (student_id, roll_no, name, father_name, semester_year, challan_no, submission_date, fees_amount) 
//         VALUES (?, ?, ?, ?, ?, ?, ?, ?)`,
//       [
//         req.user.id,
//         roll_no,
//         name,
//         father_name,
//         semester_year,
//         challan_no,
//         submission_date,
//         fees_amount
//       ]
//     );

//     return res.json({ message: 'Challan submitted successfully.' });
//   } catch (error) {
//     console.error("Upload Challan Error:", error);
//     return res.status(500).json({ message: 'Server error', error: error.message });
//   }
// };

// // Clerk: Get all pending challans
// exports.getPendingChallans = async (req, res) => {
//   const db = getConnection(); 

//   try {
//     const [results] = await db.execute(
//       // "SELECT * FROM Challans WHERE status = 'pending'"
//       `SELECT 
//     c.*, 
//     u.name AS student_name 
//    FROM Challans c
//    JOIN Users u ON c.student_id = u.id
//    WHERE c.status = 'pending'`
//     );
//     res.json(results);
//   } catch (error) {
//     console.error("Error fetching challans:", error);
//     res.status(500).json({ message: "Server error" });
//   }
// };

// // Clerk: Verify or Reject a Challan
// exports.updateChallanStatus = async (req, res) => {
//   const db = getConnection(); 

//   const { challan_id } = req.params;
//   const { status, remarks } = req.body;

//   if (!['verified', 'rejected'].includes(status)) {
//     return res.status(400).json({ message: "Invalid status value" });
//   }

//   try {
//     const [result] = await db.execute(
//       "UPDATE Challans SET status = ?, remarks = ? WHERE id = ?",
//       [status, remarks, challan_id]
//     );

//     if (result.affectedRows === 0) {
//       return res.status(404).json({ message: "Challan not found" });
//     }

//     res.json({ message: `Challan ${status} successfully.` });
//   } catch (error) {
//     console.error("Challan update error:", error);
//     res.status(500).json({ message: "Server error" });
//   }
// };

// // Student views their own challans
// exports.getStudentChallans = async (req, res) => {
//   const db = getConnection(); // FIXED: Add this line

//   const studentId = req.user.id;

//   try {
//     const [challans] = await db.query(
//       'SELECT * FROM Challans WHERE student_id = ? ORDER BY uploaded_at DESC',
//       [studentId]
//     );

//     res.json(challans);
//   } catch (error) {
//     console.error("Get Student Challans Error:", error);
//     res.status(500).json({ message: "Server error" });
//   }
// };

// // Clerk views all student challans
// exports.getAllChallans = async (req, res) => {
//   const db = getConnection(); // FIXED: Add this line

//   try {
//     const [challans] = await db.query(
//       // `SELECT 
//       //   c.*, 
//       //   u.name, u.email 
//       //  FROM Challans c 
//       //  JOIN Users u ON c.student_id = u.id
//       //  ORDER BY c.uploaded_at DESC`
//       `SELECT 
//     c.id, c.roll_no, c.name AS challan_name, c.father_name, c.semester_year,
//     c.challan_no, c.submission_date, c.fees_amount, c.status, c.remarks, c.uploaded_at,
//     u.name AS student_name, u.email
//    FROM Challans c 
//    JOIN Users u ON c.student_id = u.id
//    ORDER BY c.uploaded_at DESC`
//     );

//     res.json(challans);
//   } catch (error) {
//     console.error("Get All Challans Error:", error);
//     res.status(500).json({ message: "Server error" });
//   }
// };

const { getConnection } = require('../db');
const path = require('path');

// Student Upload Challan (with mandatory image)
exports.uploadChallan = async (req, res) => {
  const db = getConnection();

  const {
    roll_no,
    name,
    father_name,
    semester_year,
    challan_no,
    submission_date,
    fees_amount
  } = req.body;

  // image is required
  if (!req.file) {
    return res.status(400).json({ message: 'Challan image is required (field name: image).' });
  }

  try {
    // (Optional: role already enforced by middleware)
    const [user] = await db.execute('SELECT role FROM Users WHERE id = ?', [req.user.id]);
    if (!user.length || user[0].role !== 'student') {
      return res.status(403).json({ message: 'Only students can upload challans.' });
    }

    // Build a public URL path for the image (stored relative to server root)
    const relativeImageUrl = `/uploads/challans/${req.file.filename}`;

    await db.execute(
      `INSERT INTO Challans 
        (student_id, roll_no, name, father_name, semester_year, challan_no, submission_date, fees_amount, image_url) 
       VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)`,
      [
        req.user.id,
        roll_no,
        name,
        father_name,
        semester_year,
        challan_no,
        submission_date,
        fees_amount,
        relativeImageUrl
      ]
    );

    return res.status(201).json({ message: 'Challan submitted successfully.' });
  } catch (error) {
    console.error("Upload Challan Error:", error);
    return res.status(500).json({ message: 'Server error' });
  }
};

// Clerk: Get all pending challans
exports.getPendingChallans = async (req, res) => {
  const db = getConnection();
  try {
    const [results] = await db.execute(
      `SELECT 
         c.id, c.roll_no, c.name AS challan_name, c.father_name, c.semester_year,
         c.challan_no, c.submission_date, c.fees_amount, c.status, c.remarks, c.uploaded_at,
         c.image_url,                                     -- <— includes image url
         u.name AS student_name, u.email
       FROM Challans c
       JOIN Users u ON c.student_id = u.id
       WHERE c.status = 'pending'
       ORDER BY c.uploaded_at DESC`
    );
    res.json(results);
  } catch (error) {
    console.error("Error fetching challans:", error);
    res.status(500).json({ message: "Server error" });
  }
};

// Clerk: Verify or Reject a Challan
exports.updateChallanStatus = async (req, res) => {
  const db = getConnection();
  const { challan_id } = req.params;
  const { status, remarks } = req.body;

  if (!['verified', 'rejected'].includes(status)) {
    return res.status(400).json({ message: "Invalid status value" });
  }

  try {
    const [result] = await db.execute(
      "UPDATE Challans SET status = ?, remarks = ? WHERE id = ?",
      [status, remarks || null, challan_id]
    );

    if (result.affectedRows === 0) {
      return res.status(404).json({ message: "Challan not found" });
    }

    res.json({ message: `Challan ${status} successfully.` });
  } catch (error) {
    console.error("Challan update error:", error);
    res.status(500).json({ message: "Server error" });
  }
};

// Student views their own challans
exports.getStudentChallans = async (req, res) => {
  const db = getConnection();
  const studentId = req.user.id;

  try {
    const [challans] = await db.execute(
      'SELECT * FROM Challans WHERE student_id = ? ORDER BY uploaded_at DESC',
      [studentId]
    );

    // Optionally return absolute URLs for convenience
    const base = `${req.protocol}://${req.get('host')}`;
    const withUrls = challans.map(c => ({
      ...c,
      image_full_url: c.image_url ? `${base}${c.image_url}` : null
    }));

    res.json(withUrls);
  } catch (error) {
    console.error("Get Student Challans Error:", error);
    res.status(500).json({ message: "Server error" });
  }
};

// Clerk views all student challans
exports.getAllChallans = async (req, res) => {
  const db = getConnection();
  try {
    const [challans] = await db.execute(
      `SELECT 
         c.id, c.roll_no, c.name AS challan_name, c.father_name, c.semester_year,
         c.challan_no, c.submission_date, c.fees_amount, c.status, c.remarks, c.uploaded_at,
         c.image_url,                                     -- <— includes image url
         u.name AS student_name, u.email
       FROM Challans c 
       JOIN Users u ON c.student_id = u.id
       ORDER BY c.uploaded_at DESC`
    );

    const base = `${req.protocol}://${req.get('host')}`;
    const withUrls = challans.map(c => ({
      ...c,
      image_full_url: c.image_url ? `${base}${c.image_url}` : null
    }));

    res.json(withUrls);
  } catch (error) {
    console.error("Get All Challans Error:", error);
    res.status(500).json({ message: "Server error" });
  }
};
