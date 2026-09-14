const { initializeApp, cert } = require('firebase-admin/app');
const { getFirestore } = require('firebase-admin/firestore');
const { getAuth } = require('firebase-admin/auth');
const path = require('path');

let db, auth;

try {
  const serviceAccount = require('../serviceAccountKey.json');
  const app = initializeApp({
    credential: cert(serviceAccount)
  });
  console.log("Firebase Admin Initialized Successfully");
  
  db = getFirestore(app);
  auth = getAuth(app);
} catch (error) {
  console.error("Failed to initialize Firebase Admin:", error);
  process.exit(1);
}

module.exports = { db, auth };
