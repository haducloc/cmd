const path = require('path');
const webpack = require('webpack');


// https://webpack.js.org/concepts/

module.exports = {
		
    mode: 'development|production',
   
    devtool: 'none|source-map|inline-source-map',
    
    entry: {
        'app': './wwwroot/source/app.js',
        
        pageOne: './src/pageOne/index.js',
        
        pageTwo: './src/pageTwo/index.js',
        
        pageThree: './src/pageThree/index.js'
    },

    output: {
        path: path.resolve(__dirname, 'wwwroot/dist'),
        filename: '[name].js'
    },

    plugins: [
    	
    	// https://webpack.js.org/plugins/
    	
        new webpack.ProvidePlugin({
            $: 'jquery',
            jQuery: 'jquery',
            'window.jQuery': 'jquery'
        })
    ],

    module: {
        rules: [
            {
                test: /\.js?$/,
                exclude: /node_modules/,
                use: {
                    loader: 'babel-loader',
                    options: {
                        presets: [
                            '@babel/preset-env'
                        ]
                    }
                }
            },
            
            {
                test: /\.css$/,
                use: ['style-loader', 'css-loader']
            },
            
            {
                test: /\.scss$/,
                use: ['style-loader', 'css-loader', 'sass-loader']
            },
            
            {
                test: /\.(png|svg|jpg|gif)$/,
                use: [
                  'file-loader' // https://webpack.js.org/loaders/file-loader/
                ]
            }
        ]
    }
    
};