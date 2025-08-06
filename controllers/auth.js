const { response } = require('express');

const crearUsuario = (req, res = response) => {
    const { name, email, password } = req.body;



    res.status(201).json({
        ok: true,
        msg: 'Usuario creado exitosamente',
        name,
        email,
        password
    })
}

const loginUsuario = (req, res = response) => {
    const { email, password } = req.body;



    res.status(201).json({
        ok: true,
        msg: 'Usuario autenticado exitosamente',
        email,
        password
    })
}




const revalidarToken = (req, res = response) => {
    res.json({
        ok: true,
        msg: 'Token renovado exitosamente',
    })
}

module.exports = {
    crearUsuario,
    loginUsuario,
    revalidarToken
}