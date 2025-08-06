const { Router } = require('express');
const router = Router();

//rutas
router.get('/', (req, res) => {
    res.send('Hello, World!');
});


module.exports = router;