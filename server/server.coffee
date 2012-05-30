port =  process.env.PORT || 9294

express = require('express')
fs = require('fs')
Routes = require("./routes")
Pusherino = require("./pusherino")
OpfDevUtil = require("./opfDevUtil")


##Setup Server
app = express.createServer()
app.use express.logger()
app.use express.bodyParser()
app.use express.cookieParser()

OpfDevUtil.setupCompilers(app) if process.env.NODE_ENV != "production"
      
app.use(express.static("./public"))

routes = new Routes(app)

pusherino = new Pusherino()
setInterval pusherino.mock , 5000

app.listen(port)
console.log "Listening on port " + port

