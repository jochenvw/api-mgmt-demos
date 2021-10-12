import examplesRouter from './api/controllers/examples/router';

export default function routes(app) {
  app.get('/', function(req, res, next) {
    res.status(200).end();
  })
  app.use('/api/v1/examples', examplesRouter);
}
