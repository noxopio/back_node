const { Router } = require('express');
const router = Router();
const { crearUsuario } = require('../controllers/auth')

//rutas
// router.get('/', (req, res) => {
//     res.send('Hello, World!');
// });
router.post('/new',crearUsuario);


router.post('/', (req, res) => {
    res.json({
        ok: true,
        msg: 'Usuario autenticado exitosamente'
    })
});
router.get('/renew', (req, res) => {
    res.json({
        ok: true,
        msg: 'renew'
    })
});


module.exports = router;