local Config = require('config')

return Config:init()
  :append(require('config.appearance'))
  :append(require('config.transparency'))
  :append(require('config.font'))
  :append(require('config.launch'))
  :append(require('config.bindings')).options
