const express = require('express');
const cors = require('cors');
require('dotenv').config();

const userRoutes = require('./router/userRoutes');
const eventRoutes = require('./router/eventRoutes');
const certificateRoutes = require('./router/certificateRoutes');
const donationRoutes = require('./router/donationRoutes');
const inventoryRoutes = require('./router/inventoryRoutes');

const app = express();
const PORT = process.env.PORT || 5001;

app.use(cors());
app.use(express.json());

// Ignore favicon requests from browser
app.get('/favicon.ico', (req, res) => res.status(204).end());

app.get('/', (req, res) => {
  res.json({ message: 'Welcome to Pehchan NGO Management API' });
});

// Use Routers
app.use('/api/users', userRoutes);
app.use('/api/events', eventRoutes);
app.use('/api/certificates', certificateRoutes);
app.use('/api/donations', donationRoutes);
app.use('/api/inventory', inventoryRoutes);

app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
