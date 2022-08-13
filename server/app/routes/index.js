const express = require('express');
const entryCtrl = require('../controllers/entryController');
const waitlistCtrl = require('../controllers/waitlistController');

const router = express.Router();

router.route('/waitlists')
	.get((...params) => waitlistCtrl.list(...params))

router.route('/entry/:date')
	.post((...params) => entryCtrl.create(...params));

router.route('/entry/:date/:id')
	.delete((...params) => entryCtrl.removeById(...params))
	.patch((...params) => entryCtrl.updateById(...params));

module.exports = router;
