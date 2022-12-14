const Waitlist = require('../models/waitlistModel');
const { ObjectID } = require('mongodb');

const getWaitlist = async (req, res, next) => {
    const date = req.params.date
    const waitlist = await Waitlist.findOne({ date })
    return { req, res, next, waitlist, date }
}

exports.create = async (...params) => {
    let { req, res, next, waitlist, date } = await getWaitlist(...params)
    try {
        const data = req.body
        if (!waitlist) waitlist = await Waitlist.create({ date })
        let wl = await Waitlist.findOneAndUpdate(
            { _id: waitlist._id },
            { $push: { "entries": data } },
            { new: true, runValidators: true }
        );
        wl.entries = wl.entries.sort((a,b) => a.idx - b.idx)
        return res.json(wl);
    } catch (err) {
        return next(err);
    }
};

exports.removeById = async (...params) => {
    const { req, res, next, waitlist } = await getWaitlist(...params)
    const { id } = req.params;
    const data = req.body;
    if (!ObjectID.isValid(id)) {
        return next();
    }
    try {
        let wl = await Waitlist.findOneAndUpdate(
            { _id: waitlist._id },
            { $pull: { "entries": { "_id": ObjectID(id) } } },
            { new: true, runValidators: true }
        );
        wl.entries = wl.entries.sort((a,b) => a.idx - b.idx).map((entry, index) => {
            const { _id, idx, name, service, completed } = entry
            return {
                _id, name, service, completed,
                idx: index,
            }
        })
		if (!wl) {
			return next();
		}
		return res.json(wl);
    } catch (err) {
        return next(err);
    }
};

exports.updateById = async (...params) => {
    const { req, res, next, waitlist } = await getWaitlist(...params)
    const { id } = req.params;
    const data = req.body;
    if (!ObjectID.isValid(id)) {
        return next();
    }
    try {
        let wl = await Waitlist.findOneAndUpdate(
            { _id: waitlist._id },
            { $pull: { "entries": { "_id": ObjectID(id) } } },
            { new: true, runValidators: true }
        );
		if (!wl) {
			return next();
		}
        wl = await Waitlist.findOneAndUpdate(
            { _id: waitlist._id },
            { $push: { "entries": { "_id": ObjectID(id), ...data } } },
            { new: true, runValidators: true }
        );
        wl.entries = wl.entries.sort((a,b) => a.idx - b.idx)
		if (!wl) {
			return next();
		}
		return res.json(wl);
    } catch (err) {
        return next(err);
    }
};
