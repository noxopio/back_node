const {response} = require('express');

const crearUsuario = (req, res=response) => {
    res.json({ ok: true ,
        msg: 'Usuario creado exitosamente'
    })
}
module.exports = {
    crearUsuario
}