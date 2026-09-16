const { db } = require('../config/firebase');

const usersCollection = db.collection('users');

const createUser = async (uid, userData) => {
  await usersCollection.doc(uid).set({
    ...userData,
    createdAt: new Date(),
  });
  return { id: uid, ...userData };
};

const getUserById = async (uid) => {
  const doc = await usersCollection.doc(uid).get();
  if (!doc.exists) throw new Error("User not found");
  return { id: doc.id, ...doc.data() };
};

const getAllUsers = async (role) => {
  let query = usersCollection;
  if (role) {
    query = query.where('role', '==', role);
  }
  const snapshot = await query.get();
  return snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
};

module.exports = {
  createUser,
  getUserById,
  getAllUsers,
};
