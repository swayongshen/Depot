const { environment } = require('@rails/webpacker')
const webpack = require('webpack')
const path = require('path')

environment.plugins.append('Provide',
    new webpack.ProvidePlugin({
        Popper: ['popper.js', 'default'],
        $: 'jquery/src/jquery',
        jquery: 'jquery/src/jquery',
        jQuery: 'jquery/src/jquery',
    })
)

const aliasConfig = {
    'jquery': 'jquery/src/jquery',
    'jquery-ui': 'jquery-ui-dist/jquery-ui.js'

};

environment.config.set('resolve.alias', aliasConfig);


module.exports = environment
