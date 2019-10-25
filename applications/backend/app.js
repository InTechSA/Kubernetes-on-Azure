const express = require('express');
const app = express();
const logger = require('./logger');
const chance = require("chance")();
const port = 3000;

const randomLog = () => `${chance.ip()} => ${chance.url({ domain: 'intech.lu' })}`;

app.get('/', (req, res) => {
  const logs = Array(50).fill(null).map(randomLog);
  logs.forEach(logger.info);
  res.send(logs);
});

app.get('/health', (req, res) => {
  res.sendStatus(200);
});

app.listen(port, () => logger.info(`Example app listening on port ${port}!`));