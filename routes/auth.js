const { Router } = require('express');
const { check } = require('express-validator');

const router = Router();
const { crearUsuario, loginUsuario, revalidarToken } = require('../controllers/auth')

//rutas
// router.get('/', (req, res) => {
//     res.send('Hello, World!');
// });
router.post(
    '/new',
    [
        check('name', 'El nombre es obligatorio').not().isEmpty(),
        check('email', 'El email es obligatorio').isEmail(),
        check('password', 'El password es obligatorio y debe tener al menos 6 caracteres').isLength({ min: 6 })
    ],
    crearUsuario
);


router.post(
    
    '/',
    [
        check('email', 'El email es obligatorio').isEmail(),
        check('password', 'El password es obligatorio y debe tener al menos 6 caracteres').isLength({ min: 6 })
    ],
    
    
    loginUsuario);

router.get('/renew', revalidarToken);


module.exports = router;