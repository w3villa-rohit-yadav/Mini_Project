const { environment } = require('@rails/webpacker')

environment.config.merge({
  entry: {
    application: './app/javascript/packs/application.js'
  }
})

module.exports = environment
