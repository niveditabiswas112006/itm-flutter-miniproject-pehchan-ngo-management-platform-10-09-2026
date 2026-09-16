const { db } = require('../config/firebase');

const eventsCollection = db.collection('events');

const createEvent = async (eventData) => {
  const docRef = await eventsCollection.add({
    ...eventData,
    createdAt: new Date(),
    currentVolunteerCount: 0,
    status: 'registrationOpen'
  });
  return { id: docRef.id, ...eventData };
};

const getAllEvents = async () => {
  const snapshot = await eventsCollection.orderBy('createdAt', 'desc').get();
  return snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
};

const getEventById = async (eventId) => {
  const doc = await eventsCollection.doc(eventId).get();
  if (!doc.exists) throw new Error("Event not found");
  return { id: doc.id, ...doc.data() };
};

module.exports = {
  createEvent,
  getAllEvents,
  getEventById,
};
