const winston = require("winston");
const config = require("config");

const logger = winston.createLogger({
  level: config.get("LogLevel"),
  defaultMeta: { service: config.get("AppName") },
  format: winston.format.combine(
    winston.format.timestamp(),
    winston.format.logstash()
  ),
  transports: [new winston.transports.Console()]
});

module.exports = logger;