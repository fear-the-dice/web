var autoprefixer = require('autoprefixer');
var webpack = require('webpack');

module.exports = {
    entry: './app/app.js',
    output: {
        path: __dirname + '/public/dist',
        filename: 'bundle.js'
    },
    module: {
        loaders: [
            { 
                test: /\.coffee$/, 
                loader: "coffee-loader" 
            },
            {
                test: /\.(jpe?g|png|gif|svg)$/i,
                loaders: [
                    'file?hash=sha512&digest=hex&name=[hash].[ext]',
                    'image-webpack?bypassOnDebug&optimizationLevel=7&interlaced=false'
                ]
            },
            { 
                test: /\.css$/, 
                loader: 'style!css?sourceMap!postcss-loader?sourceMap' 
            },
            {
                test: /\.scss$/,
                loaders: ['style', 'css?sourceMap', 'sass?sourceMap']
            },
        ],
    },
    plugins: [
        new webpack.ProvidePlugin({
            $: "jquery",
            jQuery: "jquery",
            _: "lodash",
            "pubsub-js": "pubsub-js",
            bootstrap: "bootstrap",
            Backbone: "Backbone",
            mustache: "mustache",
        })
    ],
    postcss: [ autoprefixer({ browsers: ['last 2 versions'] }) ],
};
