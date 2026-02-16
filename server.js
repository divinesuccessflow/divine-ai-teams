const http = require('http');
const fs = require('fs');
const path = require('path');
const PORT = process.env.PORT || 3000;
const mimeTypes = {'.html':'text/html','.css':'text/css','.js':'application/javascript','.json':'application/json','.png':'image/png','.jpg':'image/jpeg','.svg':'image/svg+xml','.ico':'image/x-icon'};
http.createServer((req,res)=>{let f='.'+(req.url==='/'?'/index.html':req.url);const ext=path.extname(f).toLowerCase();fs.readFile(f,(err,c)=>{if(err){fs.readFile('./index.html',(e,c2)=>{res.writeHead(200,{'Content-Type':'text/html'});res.end(c2);})}else{res.writeHead(200,{'Content-Type':mimeTypes[ext]||'application/octet-stream'});res.end(c)}})}).listen(PORT);
