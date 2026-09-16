const express = require('express');
const router = express.Router();
const userModel = require('../models/userModel');

// Get all users (optionally filter by role)
router.get('/', async (req, res) => {
  try {
    const role = req.query.role;
    const users = await userModel.getAllUsers(role);
    res.json({ success: true, data: users });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
});

// Get user by ID
router.get('/:id', async (req, res) => {
  try {
    const user = await userModel.getUserById(req.params.id);
    res.json({ success: true, data: user });
  } catch (error) {
    res.status(404).json({ success: false, error: error.message });
  }
});

// Create new user record
router.post('/', async (req, res) => {
  try {
    const { uid, ...userData } = req.body;
    if (!uid) return res.status(400).json({ success: false, error: 'uid is required' });
    
    const newUser = await userModel.createUser(uid, userData);
    res.status(201).json({ success: true, data: newUser });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
});

module.exports = router;
