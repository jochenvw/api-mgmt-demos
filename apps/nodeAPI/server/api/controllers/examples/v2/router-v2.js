import * as express from 'express';
import ControllerV2 from './controller-v2';

export default express
  .Router()
  .post('/', ControllerV2.create)
  .get('/', ControllerV2.all)
  .get('/:id', ControllerV2.byId);
