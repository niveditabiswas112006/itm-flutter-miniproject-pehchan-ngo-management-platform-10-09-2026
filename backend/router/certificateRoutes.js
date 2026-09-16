const express = require('express');
const router = express.Router();
const certificateModel = require('../models/certificateModel');

// Get certificate by ID
router.get('/:id', async (req, res) => {
  try {
    const cert = await certificateModel.getCertificateById(req.params.id);
    res.json({ success: true, data: cert });
  } catch (error) {
    res.status(404).json({ success: false, error: error.message });
  }
});

// Get all certificates for a user
router.get('/user/:userId', async (req, res) => {
  try {
    const certs = await certificateModel.getCertificatesByUser(req.params.userId);
    res.json({ success: true, data: certs });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
});

// Create new certificate
router.post('/', async (req, res) => {
  try {
    const newCert = await certificateModel.createCertificate(req.body);
    res.status(201).json({ success: true, data: newCert });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
});

module.exports = router;
