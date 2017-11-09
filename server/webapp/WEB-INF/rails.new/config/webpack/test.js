const merge        = require('webpack-merge');
const environment  = require('./environment');
const customConfig = require('./customizations');
const devAndTest = require('./dev-and-test');

module.exports = merge(environment.toWebpackConfig(), customConfig, devAndTest);
