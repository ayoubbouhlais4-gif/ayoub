const express = require('express');
const app = express();
const PORT = 3000;

app.get('/', (req, res) => {
  res.status(200).json({ message: 'Hello from server.js', status: 'running' });
});

// Health check endpoint used by Jenkins to verify the container is really up
app.get('/health', (req, res) => {
  res.status(200).json({ status: 'ok' });
});

app.listen(PORT, () => {
  console.log(`Server listening on port ${PORT}`);

module.exports = app;
