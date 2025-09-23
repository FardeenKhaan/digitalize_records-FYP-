const { getConnection } = require('../db');

// Clerk: Add student to roll number list
exports.createStudent = async (req, res) => {
    const db = getConnection();
  const { name, father_name, roll_number, section } = req.body;
  const created_by = req.user.id;

  try {
    await db.query(
      'INSERT INTO RollNumberList (name, father_name, roll_number, section, created_by) VALUES (?, ?, ?, ?, ?)',
      [name, father_name, roll_number, section, created_by]
    );
    res.json({ message: "Student added to roll number list." });
  } catch (error) {
    console.error("Create Student Error:", error);
    res.status(500).json({ message: "Server error", error: error.message });
  }
};

// Clerk or Student: View list
exports.getList = async (req, res) => {
    const db = getConnection();
  try {
    const [rows] = await db.query(
      `SELECT id, name, father_name, roll_number, section, created_at FROM RollNumberList ORDER BY created_at DESC`
    );
    res.json(rows);
  } catch (error) {
    console.error("Fetch List Error:", error);
    res.status(500).json({ message: "Server error" });
  }
};

// Clerk: Update student info
exports.updateStudent = async (req, res) => {
    const db = getConnection();
  const { id } = req.params;
  const { name, father_name, roll_number, section } = req.body;

  try {
    await db.query(
      `UPDATE RollNumberList SET name = ?, father_name = ?, roll_number = ?, section = ? WHERE id = ?`,
      [name, father_name, roll_number, section, id]
    );
    res.json({ message: "Student info updated." });
  } catch (error) {
    console.error("Update Student Error:", error);
    res.status(500).json({ message: "Server error" });
  }
};

// Clerk: Delete student record
exports.deleteStudent = async (req, res) => {
    const db = getConnection();
  const { id } = req.params;

  try {
    await db.query(`DELETE FROM RollNumberList WHERE id = ?`, [id]);
    res.json({ message: "Student deleted from list." });
  } catch (error) {
    console.error("Delete Student Error:", error);
    res.status(500).json({ message: "Server error" });
  }
};
