const Waitlist = require('../models/waitlistModel');

exports.list = async (req, res, next) => {
    try {
		const waitlists = await Waitlist.find({});
    const formatted = waitlists.map(wl => {
      const { date, entries } = wl;
      return { date, entries }
    })
		return res.json(formatted);
    } catch (err) {
        return next(err);
    }
};