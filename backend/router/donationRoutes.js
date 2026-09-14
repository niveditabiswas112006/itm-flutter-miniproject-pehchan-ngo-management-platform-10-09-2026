const express = require('express');
const router = express.Router();
const donationModel = require('../models/donationModel');

// Get all donations
router.get('/', async (req, res) => {
  try {
    const donations = await donationModel.getAllDonations();
    res.json({ success: true, data: donations });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
});

// Get donations by NGO
router.get('/ngo/:ngoId', async (req, res) => {
  try {
    const donations = await donationModel.getDonationsByNgo(req.params.ngoId);
    res.json({ success: true, data: donations });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
});

// Create new donation
router.post('/', async (req, res) => {
  try {
    const newDonation = await donationModel.createDonation(req.body);
    res.status(201).json({ success: true, data: newDonation });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
});

module.exports = router;
