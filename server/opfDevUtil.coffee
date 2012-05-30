fs = require('fs')


class OpfDevUtil

  @setupCompilers: (app) ->
    Hem = require("hem")
    Less = require('less')  
    hem = new Hem()

    app.get(hem.options.jsPath, hem.hemPackage().createServer())

    app.get hem.options.cssPath , (req,res) =>
      res.header("Content-type", "text/css")
      path = "./css/index.less"
      try
        parser = new(Less.Parser)( { paths: ['./css/bootstrap', './css/'] , filename: 'index.less' } )
        fs.readFile path, "utf8" , (err, data) =>
          parser.parse data, (err, css) ->
            res.send(css.toCSS())
      catch error
        res.send("")
    
  

module.exports = OpfDevUtil
