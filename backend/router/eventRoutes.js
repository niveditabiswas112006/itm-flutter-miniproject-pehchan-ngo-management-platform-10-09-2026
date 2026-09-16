const express = require('express');
const router = express.Router();
const eventModel = require('../models/eventModel');

// Get all events
router.get('/', async (req, res) => {
  try {
    const events = await eventModel.getAllEvents();
    res.json({ success: true, data: events });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
});

// Get single event
router.get('/:id', async (req, res) => {
  try {
    const event = await eventModel.getEventById(req.params.id);
    res.json({ success: true, data: event });
  } catch (error) {
    res.status(404).json({ success: false, error: error.message });
  }
});

// Create new event
router.post('/', async (req, res) => {
  try {
    const newEvent = await eventModel.createEvent(req.body);
    res.status(201).json({ success: true, data: newEvent });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
});

module.exports = router;
