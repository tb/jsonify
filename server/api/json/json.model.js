'use strict';

var mongoose = require('mongoose'),
    Schema = mongoose.Schema;

var jsonSchema = new Schema({
  json: String
});

module.exports = mongoose.model('json', jsonSchema);