import * as express from 'express';
import ControllerV1 from './controller-v1';

export default express
  .Router()
  .post('/', ControllerV1.create)
  .get('/', ControllerV1.all)
  .get('/:id', ControllerV1.byId);
