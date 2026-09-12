 p = require('express');
 l = require('http');
 g = require('bcryptjs');
 denv = require('dotenv');
 jwt = require("jsonwebtoken");
 core = require('cors');
 database = require('sql2/promise');
 app = p();
 PORT = 3000;
 denv.config();
 app.listen(PORT,()=>{console.log('server is runnign on port 3000');
 })
 function connectDB(){
     database.createConnection({
         host : proccess.env.PORT || 3122,
         user : prcocess.env.DB_SERVER_USER || 'root',
         password : process.env.DB_SERVER_USER||'ayoub1234',
         database : process.env.DB_NAME || 'notes'
     })
 }
app = json();
function login(req,res){
     const {email,password} = req.body;
     if(!email || !password){
        res.status(400).json({message:'please provide email and password'});
     }
     
}
