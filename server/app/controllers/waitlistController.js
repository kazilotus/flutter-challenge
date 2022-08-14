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

exports.update = async (req, res, next) => {
    try {
      const date = req.params.date
      const data = req.body;
      const entries = data.entries;
      wl = await Waitlist.updateOne(
        { date: date },
        { $set: {
          entries: entries
        } },
      );
      return this.list(req, res, next);
    } catch (err) {
        return next(err);
    }
};