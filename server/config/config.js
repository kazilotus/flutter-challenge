
require('dotenv').config();

const envVars = process.env;

const config = {
	port: envVars.PORT,
	db: {
		host: envVars.DB_HOST,
		port: envVars.DB_PORT,
	},
};

module.exports = config;
