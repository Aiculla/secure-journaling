require('dotenv').config();

module.exports = {
  transpileDependencies: true,
  configureWebpack: (config) => {
    config.plugins.push(
      new (require('webpack')).DefinePlugin({
        'process.env.VUE_AWS_ACCESS_KEY': JSON.stringify(process.env.VUE_AWS_ACCESS_KEY),
        'process.env.VUE_AWS_SECRET_KEY': JSON.stringify(process.env.VUE_AWS_SECRET_KEY),
      })
    );
  },
};
