const {environment} = require('@rails/webpacker');
const StatsPlugin   = require('stats-webpack-plugin');
const webpack       = require('webpack');
const fs            = require('fs');
const fsExtra       = require('fs-extra');
const _             = require('lodash');
const path          = require('path');
const webpackerYml  = require('@rails/webpacker/package/config');
const assetHost     = require('@rails/webpacker/package/asset_host');
const assetsDir     = path.join(__dirname, '..', '..', webpackerYml.source_path);

const babelLoader = environment.loaders.get('babel');
babelLoader.test  = /\.(js|jsx|msx)?(\.erb)?$/;

console.log(`Generating assets in ${assetHost.path}`);
fsExtra.removeSync(assetHost.path);

environment.plugins.set('Provide',
  new webpack.ProvidePlugin({
    $:               "jquery",
    jQuery:          "jquery",
    "window.jQuery": "jquery"
  })
);

environment.plugins.set(
  'CommonsChunkVendor',
  new webpack.optimize.CommonsChunkPlugin({
    name:      'vendor-and-helpers.chunk',
    filename:  process.env.NODE_ENV == 'production' ? '[name]-[chunkhash].js' : '[name].js',
    minChunks: function (module, _count) {
      function isFromNPM() {
        return new RegExp(`node_modules`).test(module.resource);
      }

      function isInside() {
        return fs.realpathSync(module.resource).indexOf(fs.realpathSync(path.join(assetsDir, ..._(Array.prototype.concat.apply([], arguments)).flattenDeep().compact().value()))) === 0;
      }

      return module.resource && (isFromNPM() || isInside('helpers') || isInside('gen') || isInside('models', 'shared') || isInside('models', 'mixins') || isInside('views', 'shared'));
    },
  })
);

environment.plugins.set('StatsPlugin',
  new StatsPlugin('manifest-stats.json', {
    chunkModules: false,
    source:       false,
    chunks:       false,
    modules:      false,
    assets:       true
  })
);

environment.plugins.set('DefinePlugin',
  new webpack.DefinePlugin({'process.env': {NODE_ENV: JSON.stringify(process.env.NODE_ENV || 'development')}})
);

// run `yarn add --dev webpack-bundle-analyzer` to analyze dependencies and run with `--watch` arg
//const BundleAnalyzerPlugin = require('webpack-bundle-analyzer').BundleAnalyzerPlugin;
//environment.plugins.set('BundleAnalyzerPlugin', new BundleAnalyzerPlugin({analyzerPort: 9999}));

module.exports = environment;
