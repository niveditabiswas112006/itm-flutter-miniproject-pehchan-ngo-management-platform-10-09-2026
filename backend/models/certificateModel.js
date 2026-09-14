const { db } = require('../config/firebase');

const certificatesCollection = db.collection('certificates');

const createCertificate = async (certificateData) => {
  const docRef = await certificatesCollection.add({
    ...certificateData,
    issueDate: new Date(),
    verified: true,
  });
  return { id: docRef.id, ...certificateData };
};

const getCertificateById = async (certificateId) => {
  const doc = await certificatesCollection.doc(certificateId).get();
  if (!doc.exists) throw new Error("Certificate not found");
  return { id: doc.id, ...doc.data() };
};

const getCertificatesByUser = async (userId) => {
  const snapshot = await certificatesCollection.where('userId', '==', userId).get();
  return snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
};

module.exports = {
  createCertificate,
  getCertificateById,
  getCertificatesByUser,
};
