const { db } = require('../config/firebase');

const donationsCollection = db.collection('donations');

const createDonation = async (donationData) => {
  const docRef = await donationsCollection.add({
    ...donationData,
    createdAt: new Date(),
    status: 'successful'
  });
  return { id: docRef.id, ...donationData };
};

const getDonationsByNgo = async (ngoId) => {
  const snapshot = await donationsCollection.where('ngoId', '==', ngoId).get();
  return snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
};

const getAllDonations = async () => {
  const snapshot = await donationsCollection.orderBy('createdAt', 'desc').get();
  return snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
};

module.exports = {
  createDonation,
  getDonationsByNgo,
  getAllDonations,
};
