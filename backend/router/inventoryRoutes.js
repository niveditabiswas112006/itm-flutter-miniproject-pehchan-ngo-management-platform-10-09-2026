const express = require('express');
const router = express.Router();
const inventoryModel = require('../models/inventoryModel');

// Get inventory by NGO
router.get('/ngo/:ngoId', async (req, res) => {
  try {
    const items = await inventoryModel.getInventoryByNgo(req.params.ngoId);
    res.json({ success: true, data: items });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
});

// Add new inventory item
router.post('/', async (req, res) => {
  try {
    const newItem = await inventoryModel.addInventoryItem(req.body);
    res.status(201).json({ success: true, data: newItem });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
});

// Update inventory item
router.put('/:id', async (req, res) => {
  try {
    const updated = await inventoryModel.updateInventoryItem(req.params.id, req.body);
    res.json({ success: true, data: updated });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
});

module.exports = router;
