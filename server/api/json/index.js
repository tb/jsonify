'use strict';

var express = require('express');
var controller = require('./json.controller');

var router = express.Router();

/*router.get('/', controller.index); */
router.get('/:id', controller.get);
router.post('/', controller.create);
router.post('/:id', controller.create);
/*
router.patch('/:id', controller.update);
router.delete('/:id', controller.destroy);*/

module.exports = router;