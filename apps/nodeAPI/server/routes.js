import examplesRouterV1 from './api/controllers/examples/v1/router-v1';
import examplesRouterV2 from './api/controllers/examples/v2/router-v2';
import express from 'express';
var path = require('path');

export default function routes(app) {
  app.get('/', function(req, res, next) {
    res.status(200).end();
  });
  app.use('/spec', express.static(path.join(__dirname, 'common')));
  app.use('/api/v1/examples', examplesRouterV1);
  app.use('/api/v2/examples', examplesRouterV2);

}
