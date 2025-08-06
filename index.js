/*
 Rutas de Usuario / Auth 
 host +/api/auth
*/

const express = require('express');
require('dotenv').config();
//crear el servidor de express
const app = express();

//Directorio Publico
app.use(express.static('public'));

// Parse JSON bodies
app.use(express.json());

//rutas
app.use('/api/auth', require('./routes/auth'));

//Escuchar peticiones
app.listen(process.env.PORT, () => {
  console.log(`Server is running on port ${process.env.PORT}`);
});