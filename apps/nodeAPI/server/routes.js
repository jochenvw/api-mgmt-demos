import examplesRouter from './api/controllers/examples/router';
import express from 'express';
var path = require('path');

export default function routes(app) {
  app.get('/', function(req, res, next) {
    res.status(200).end();
  });
  app.use('/spec', express.static(path.join(__dirname, 'common')));
  app.use('/api/v1/examples', examplesRouter);
}
