const merge        = require('webpack-merge');
const environment  = require('./environment');
const customConfig = require('./customizations');

module.exports = merge(environment.toWebpackConfig(), customConfig)

