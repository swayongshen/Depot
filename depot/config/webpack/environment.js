const { environment } = require('@rails/webpacker')
const webpack = require('webpack')
const path = require('path')

environment.plugins.append('Provide',
    new webpack.ProvidePlugin({
        Popper: ['popper.js', 'default'],
        $: 'jquery',
        jQuery: 'jquery',
    })
)

module.exports = environment
