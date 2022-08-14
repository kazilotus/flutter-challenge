const Waitlist = require('../models/waitlistModel');

exports.list = async (req, res, next) => {
    try {
		const waitlists = await Waitlist.find({});
    const formatted = waitlists.map(wl => {
      const { date, entries } = wl;
      return { date, entries }
    })
            // result = result.map(r => {
        //     return {
        //         ...r,
        //         entries: r.entries.sort((a,b) => a.idx - b.idx)
        //     }
        // })
		return res.json(formatted);
    } catch (err) {
        return next(err);
    }
};