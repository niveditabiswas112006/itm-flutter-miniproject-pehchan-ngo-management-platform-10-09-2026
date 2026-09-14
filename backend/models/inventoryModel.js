const { db } = require('../config/firebase');

const inventoryCollection = db.collection('inventory');

const addInventoryItem = async (itemData) => {
  const docRef = await inventoryCollection.add({
    ...itemData,
    lastUpdated: new Date(),
  });
  return { id: docRef.id, ...itemData };
};

const getInventoryByNgo = async (ngoId) => {
  const snapshot = await inventoryCollection.where('ngoId', '==', ngoId).get();
  return snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
};

const updateInventoryItem = async (itemId, updates) => {
  await inventoryCollection.doc(itemId).update({
    ...updates,
    lastUpdated: new Date(),
  });
  return { id: itemId, ...updates };
};

module.exports = {
  addInventoryItem,
  getInventoryByNgo,
  updateInventoryItem,
};
