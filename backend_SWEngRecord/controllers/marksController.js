const { getConnection } = require('../db');

// Clerk: add marks
exports.addMarks = async (req, res) => {
  const db = getConnection();
  const {
    student_roll_no,
    semester,
    chairman_marks,
    supervisor_marks,
    external_marks,
    internal_marks
  } = req.body;

  try {
    // Find student by roll_no
    const [student] = await db.execute(
      "SELECT id, role FROM Users WHERE student_roll_no = ?",
      [student_roll_no]
    );
    if (!student.length || student[0].role !== "student") {
      return res.status(404).json({ message: "Student not found." });
    }

    await db.execute(
      `INSERT INTO StudentFYPMarks 
        (student_id, student_roll_no, semester, chairman_marks, supervisor_marks, external_marks, internal_marks)
       VALUES (?,?,?,?,?,?,?)`,
      [
        student[0].id,
        student_roll_no,
        semester,
        chairman_marks,
        supervisor_marks,
        external_marks,
        internal_marks
      ]
    );

    res.status(201).json({ message: "Marks added successfully." });
  } catch (err) {
    console.error("Add Marks Error:", err);
    res.status(500).json({ message: "Server error" });
  }
};

// Clerk: update marks
exports.updateMarks = async (req, res) => {
  const db = getConnection();
  const { marks_id } = req.params;
  const { chairman_marks, supervisor_marks, external_marks, internal_marks } = req.body;

  try {
    const [result] = await db.execute(
      `UPDATE StudentFYPMarks 
       SET chairman_marks=?, supervisor_marks=?, external_marks=?, internal_marks=? 
       WHERE id=?`,
      [chairman_marks, supervisor_marks, external_marks, internal_marks, marks_id]
    );

    if (result.affectedRows === 0) {
      return res.status(404).json({ message: "Marks not found." });
    }

    res.json({ message: "Marks updated successfully." });
  } catch (err) {
    console.error("Update Marks Error:", err);
    res.status(500).json({ message: "Server error" });
  }
};

// Clerk: delete marks
exports.deleteMarks = async (req, res) => {
  const db = getConnection();
  const { marks_id } = req.params;

  try {
    const [result] = await db.execute("DELETE FROM StudentFYPMarks WHERE id = ?", [marks_id]);
    if (result.affectedRows === 0) {
      return res.status(404).json({ message: "Marks not found." });
    }
    res.json({ message: "Marks deleted successfully." });
  } catch (err) {
    console.error("Delete Marks Error:", err);
    res.status(500).json({ message: "Server error" });
  }
};

// Clerk: filter by roll number
exports.getMarksByRollNo = async (req, res) => {
  const db = getConnection();
  const { roll_no } = req.params;

  try {
    const [marks] = await db.execute(
      `SELECT * FROM StudentFYPMarks WHERE student_roll_no = ? ORDER BY semester`,
      [roll_no]
    );

    if (!marks.length) {
      return res.status(404).json({ message: "No marks found for this roll number." });
    }

    res.json(marks);
  } catch (err) {
    console.error("Get Marks By RollNo Error:", err);
    res.status(500).json({ message: "Server error" });
  }
};

// Student: view own marks
exports.getMyMarks = async (req, res) => {
  const db = getConnection();
  try {
    const [marks] = await db.execute(
      "SELECT * FROM StudentFYPMarks WHERE student_id = ? ORDER BY semester",
      [req.user.id]
    );

    if (!marks.length) {
      return res.status(404).json({ message: "No marks found." });
    }

    res.json(marks);
  } catch (err) {
    console.error("Get My Marks Error:", err);
    res.status(500).json({ message: "Server error" });
  }
};

// Clerk: view all marks
exports.getAllMarks = async (req, res) => {
  const db = getConnection();
  try {
    const [marks] = await db.execute(
      `SELECT m.*, u.name, u.email
       FROM StudentFYPMarks m
       JOIN Users u ON m.student_id = u.id
       ORDER BY m.created_at DESC`
    );
    res.json(marks);
  } catch (err) {
    console.error("Get All Marks Error:", err);
    res.status(500).json({ message: "Server error" });
  }
};
