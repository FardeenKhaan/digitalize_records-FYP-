// const { getConnection } = require('../db');

// // Clerk posts an announcement
// exports.createAnnouncement = async (req, res) => {
//    const db = getConnection();
//   const { title, message } = req.body;
//   const posted_by = req.user.id;

//   try {
//     await db.query(
//       'INSERT INTO Announcements (title, message, posted_by) VALUES (?, ?, ?)',
//       [title, message, posted_by]
//     );

//     res.json({ message: "Announcement posted successfully." });
//   } catch (error) {
//     console.error("Create Announcement Error:", error);
//     res.status(500).json({ message: "Server error" });
//   }
// };

// // Students fetch all announcements
// exports.getAnnouncements = async (req, res) => {
//    const db = getConnection();
//   try {
//     const [announcements] = await db.query(`
//       SELECT a.id, a.title, a.message, a.created_at, u.name AS posted_by
//       FROM Announcements a
//       JOIN Users u ON a.posted_by = u.id
//       ORDER BY a.created_at DESC
//     `);

//     res.json(announcements);
//   } catch (error) {
//     console.error("Get Announcements Error:", error);
//     res.status(500).json({ message: "Server error" });
//   }
// };

const { getConnection } = require('../db');

// 1. Create announcement (Clerk)
exports.createAnnouncement = async (req, res) => {
  const db = getConnection();
  const { title, message } = req.body;
  const posted_by = req.user.id;

  try {
    await db.query(
      'INSERT INTO Announcements (title, message, posted_by) VALUES (?, ?, ?)',
      [title, message, posted_by]
    );
    res.json({ message: "Announcement posted successfully." });
  } catch (error) {
    console.error("Create Announcement Error:", error);
    res.status(500).json({ message: "Server error" });
  }
};

// 2. Get all announcements OR filtered by date
exports.getAnnouncements = async (req, res) => {
  const db = getConnection();
  const date = req.query.date;

  try {
    let query = `
      SELECT a.id, a.title, a.message, a.created_at, u.name AS posted_by
      FROM Announcements a
      JOIN Users u ON a.posted_by = u.id
    `;
    const params = [];

    if (date) {
      query += " WHERE DATE(a.created_at) = ?";
      params.push(date);
    }

    query += " ORDER BY a.created_at DESC";

    const [announcements] = await db.query(query, params);

    res.json(announcements);
  } catch (error) {
    console.error("Get Announcements Error:", error);
    res.status(500).json({ message: "Server error" });
  }
};

// 3. Update announcement (Clerk)
exports.updateAnnouncement = async (req, res) => {
  const db = getConnection();
  const { id } = req.params;
  const { title, message } = req.body;
  const userId = req.user.id;

  try {
    const [rows] = await db.query('SELECT * FROM Announcements WHERE id = ?', [id]);

    if (rows.length === 0) {
      return res.status(404).json({ message: "Announcement not found" });
    }

    if (rows[0].posted_by !== userId) {
      return res.status(403).json({ message: "Unauthorized: You can only edit your own announcements" });
    }

    await db.query(
      'UPDATE Announcements SET title = ?, message = ? WHERE id = ?',
      [title, message, id]
    );

    res.json({ message: "Announcement updated successfully" });
  } catch (error) {
    console.error("Update Error:", error);
    res.status(500).json({ message: "Server error" });
  }
};

// 4. Delete announcement (Clerk)
exports.deleteAnnouncement = async (req, res) => {
  const db = getConnection();
  const { id } = req.params;
  const userId = req.user.id;

  try {
    const [rows] = await db.query('SELECT * FROM Announcements WHERE id = ?', [id]);

    if (rows.length === 0) {
      return res.status(404).json({ message: "Announcement not found" });
    }

    if (rows[0].posted_by !== userId) {
      return res.status(403).json({ message: "Unauthorized: You can only delete your own announcements" });
    }

    await db.query('DELETE FROM Announcements WHERE id = ?', [id]);

    res.json({ message: "Announcement deleted successfully" });
  } catch (error) {
    console.error("Delete Error:", error);
    res.status(500).json({ message: "Server error" });
  }
};
