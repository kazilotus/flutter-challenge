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
        const result = await Waitlist.findOneAndUpdate(
            { _id: waitlist._id },
            { $push: { "entries": data } },
            { new: true, runValidators: true }
        );
        return res.json(result);
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
        const entry = await Waitlist.findOneAndUpdate(
            { _id: waitlist._id },
            { $pull: { "entries": { "_id": ObjectID(id) } } },
            { new: true, runValidators: true }
        );
		if (!entry) {
			return next();
		}
		return res.json(entry);
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
        let entry = await Waitlist.findOneAndUpdate(
            { _id: waitlist._id },
            { $pull: { "entries": { "_id": ObjectID(id) } } },
            { new: true, runValidators: true }
        );
		if (!entry) {
			return next();
		}
        entry = await Waitlist.findOneAndUpdate(
            { _id: waitlist._id },
            { $push: { "entries": { "_id": ObjectID(id), ...data } } },
            { new: true, runValidators: true }
        );
		if (!entry) {
			return next();
		}
		return res.json(entry);
    } catch (err) {
        return next(err);
    }
};
