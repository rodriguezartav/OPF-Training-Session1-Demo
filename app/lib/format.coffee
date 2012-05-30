Array::unique = ->
  output = {}
  output[@[key]] = @[key] for key in [0...@length]
  value for key, value of output


Number.prototype.toMoney = (decimals = 2, decimal_separator = ".", thousands_separator = ",") ->
  n = this
  c = if isNaN(decimals) then 2 else Math.abs decimals
  sign = if n < 0 then "-" else ""
  i = parseInt(n = Math.abs(n).toFixed(c)) + ''
  j = if (j = i.length) > 3 then j % 3 else 0
  x = if j then i.substr(0, j) + thousands_separator else ''
  y = i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + thousands_separator)
  z = if c then decimal_separator + Math.abs(n - i).toFixed(c).slice(2) else ''
  sign + x + y + z

Number.prototype.toSmallLabel = ->
  n = this
  i = parseInt(n = Math.abs(n).toFixed(0)) + ''

  if i.length > 6
    return (n / 1000000).toFixed(1) + 'm'
  if i.length > 5
    return (n / 1000000).toFixed(1) + 'm'
  else if i.length > 3
    return (n / 1000).toFixed(0) + 'k'
  return this.toMoney(0)

Number.prototype.toSmallPrice = ->
  n = this
  i = parseInt(n = Math.abs(n).toFixed(0)) + ''

  if i.length > 6
    return n / 1000000 + 'm'
  else if i.length > 5
    return i.substr(0, 3) + "k"
  else if i.length == 5
    return i.substr(0, 2) + "." + i[3] +  "k"
  return this.toMoney(0)

String.replaceAll = (txt, replace, with_this) ->
  return txt.replace(new RegExp(replace, 'g'),with_this)


String.prototype.capitalize = -> 
  str = this.toLowerCase()
  str = str.replace(', s.a.','')
  str = str.replace('s.a.','')
  return str.replace( /(^|\s)([a-z])/g , (m,p1,p2) -> return p1+p2.toUpperCase() )

Date.prototype.toSimple = ->
  months = this.getMonth() + 1
  months = "0" + months if months < 10
 
  date = this.getDate()
  date = "0" + date if date < 10
  str = ""
  str += this.getFullYear()
  str += "-"
  str += months
  str += "-"
  str += date
  str

Date.prototype.to_salesforce_date = ->
  months = this.getMonth() + 1
  months = "0" + months if months < 10
 
  date = this.getDate()
  date = "0" + date if date < 10
 
  str = ""
  str += this.getFullYear()
  str += "-"
  str += months
  str += "-"
  str += date
  return str

Date.prototype.to_salesforce = ->
  hours = this.getUTCHours()
  hours = "0" + hours if hours < 10
 
  minutes = this.getUTCMinutes()
  minutes = "0" + minutes if minutes < 10
 
  months = this.getUTCMonth() + 1
  months = "0" + months if months < 10
 
  date = this.getUTCDate()
  date = "0" + date if date < 10
 
  str = ""
  str += this.getUTCFullYear()
  str += "-"
  str += months
  str += "-"
  str += date
  str += "T"
  str += hours
  str += ":"
  str += minutes
  str += ":"
  str += "00Z"
  return str




