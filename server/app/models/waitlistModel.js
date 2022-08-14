const mongoose = require('mongoose');

const entrySchema = mongoose.Schema({
    idx: {
        type: Number,
        default: 0,
    },
    name: {
        type: String,
        // required: [true, 'You should enter a name'],
        // minlength: [3, 'Text should be at least 3 characters'],
        trim: true,
    },
    service: {
        type: String,
        default: "",
    },
    completed: {
        type: Boolean,
        default: false,
    },
    // completedAt: {
    //     type: Number,
    //     default: null,
    // },
});

const waitlistSchema = mongoose.Schema({
    entries: [
        entrySchema
    ],
    date: {
        type: String,
        default: formattedDate(new Date()),
    },
});

function formattedDate(d) {
	let month = String(d.getMonth() + 1);
	let day = String(d.getDate());
	const year = String(d.getFullYear());

	if (month.length < 2) month = `0${month}`;
	if (day.length < 2) day = `0${day}`;

	return `${day}-${month}-${year}`;
}

module.exports = mongoose.model('Waitlist', waitlistSchema);
