const { db } = require('./config/firebase');

const seedData = async () => {
  console.log('Seeding dummy users...');
  const users = [
    { uid: 'admin_1', name: 'Admin User', email: 'admin@pehchan.org', role: 'admin', city: 'New Delhi', bio: 'System Administrator' },
    { uid: 'ngo_1', name: 'Green Earth NGO', email: 'contact@greenearth.org', role: 'ngo', city: 'Mumbai', bio: 'Dedicated to planting trees.' },
    { uid: 'vol_1', name: 'Rahul Sharma', email: 'rahul@example.com', role: 'volunteer', city: 'Bangalore', bio: 'Enthusiastic volunteer.' },
  ];
  
  for (const user of users) {
    const { uid, ...data } = user;
    await db.collection('users').doc(uid).set({
      ...data,
      createdAt: new Date(),
    });
  }

  console.log('Seeding dummy events...');
  const events = [
    {
      ngoId: 'ngo_1', ngoName: 'Green Earth NGO', title: 'Mega Tree Plantation Drive',
      description: 'Join us to plant 10,000 trees across the city.', category: 'treePlantation',
      location: 'Mumbai', status: 'registrationOpen', maxVolunteers: 500, currentVolunteerCount: 120,
    }
  ];

  for (const event of events) {
    await db.collection('events').add({
      ...event,
      createdAt: new Date(),
    });
  }

  console.log('Seeding Complete!');
  process.exit();
};

seedData().catch(console.error);
