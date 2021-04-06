const { environment } = require('@rails/webpacker')

// https://qiita.com/1024xx4/items/56172d140d7208230e32
const webpack = require('webpack')

environment.plugins.append('Provide', new webpack.ProvidePlugin({
   $: 'jquery/src/jquery',
   jQuery: 'jquery/src/jquery',
   Popper: ['popper.js', 'default']
}))

module.exports = environment
