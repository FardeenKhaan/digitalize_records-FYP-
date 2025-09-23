

const { getConnection } = require('../db');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');

// exports.register = async (req, res) => {
//   const { name, student_roll_no, email, password, role } = req.body;

//   if (!name || !student_roll_no || !email || !password || !role) {
//     return res.status(400).json({ message: "All fields are required" });
//   }

//   try {
//     const db = getConnection();

//     const [existing] = await db.execute("SELECT * FROM Users WHERE email = ?", [email]);
//     if (existing.length > 0) {
//       return res.status(409).json({ message: "Email already exists" });
//     }

//     const hashedPassword = await bcrypt.hash(password, 10);

//     await db.execute(
//       "INSERT INTO Users (name, student_roll_no, email, password, role) VALUES (?, ?, ?, ?, ?)",
//       [name, student_roll_no, email, hashedPassword, role]
//     );

//     res.status(201).json({ message: "User registered successfully" });
//   } catch (err) {
//     console.error("Register error:", err);
//     res.status(500).json({ message: "Server error" });
//   }
// };

exports.register = async (req, res) => {
  const { name, student_roll_no, email, password, role } = req.body;

  if (!name || !email || !password || !role) {
    return res.status(400).json({ message: "Name, email, password, and role are required" });
  }

  // Roll no should only be required for students
  if (role === "student" && !student_roll_no) {
    return res.status(400).json({ message: "Student roll number is required for students" });
  }

  try {
    const db = getConnection();

    // check duplicate email
    const [existing] = await db.execute("SELECT * FROM Users WHERE email = ?", [email]);
    if (existing.length > 0) {
      return res.status(409).json({ message: "Email already exists" });
    }

    const hashedPassword = await bcrypt.hash(password, 10);

    await db.execute(
      "INSERT INTO Users (name, student_roll_no, email, password, role) VALUES (?, ?, ?, ?, ?)",
      [name, student_roll_no || null, email, hashedPassword, role]
    );

    res.status(201).json({ message: "User registered successfully" });
  } catch (err) {
    console.error("Register error:", err);
    res.status(500).json({ message: "Server error" });
  }
};



exports.login = async (req, res) => {
  const { email, password } = req.body;

  try {
    const db = getConnection();
    const [rows] = await db.execute(
      "SELECT * FROM Users WHERE email = ?",
      [email]
    );

    const user = rows[0];
    if (!user) {
      return res.status(401).json({ message: "Invalid credentials" });
    }

    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) {
      return res.status(401).json({ message: "Invalid credentials" });
    }

    // const token = jwt.sign(
    //   { id: user.id, role: user.role},
    //   process.env.JWT_SECRET || "fallback_secret",
    //   { expiresIn: "1d" }
    // );
    const token = jwt.sign(
  { id: user.id, role: user.role, student_roll_no: user.student_roll_no },
  process.env.JWT_SECRET || "fallback_secret",
  { expiresIn: "1d" }
);


    res.json({ token, role: user.role, name: user.name});
  } catch (err) {
    console.error("Login error:", err);
    res.status(500).json({ message: "Server error" });
  }
};
