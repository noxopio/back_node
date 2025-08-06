const express = require('express');
require('dotenv').config();
//crear el servidor de express
const app = express();


app.use(express.static('public'));

app.use('/api/auth', require('./routes/auth'));

//Escuchar peticiones
app.listen(process.env.PORT, () => {
  console.log(`Server is running on port ${process.env.PORT}`);
});