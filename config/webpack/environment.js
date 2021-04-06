const { environment } = require('@rails/webpacker')

// https://qiita.com/1024xx4/items/56172d140d7208230e32
// https://qiita.com/kazutosato/items/d47b7705ee545de4cb1a
const webpack = require('webpack')

environment.plugins.append('Provide', new webpack.ProvidePlugin({
   $: 'jquery/src/jquery',
   jQuery: 'jquery/src/jquery',
   Popper: ['popper.js', 'default']
}))

module.exports = environment
