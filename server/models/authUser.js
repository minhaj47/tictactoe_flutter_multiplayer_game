const mongoose = require("mongoose");

const authUserSchema = new mongoose.Schema({
  phoneNumber: {
    type: String,
    required: true,
    unique: false,
    trim: true,
  },
  otp: {
    type: String,
    required: true
  },
  createdAt: {
    type: Date,
    default: Date.now,
    expires: 300
  }
});

const authUserModel = mongoose.model('otp', authUserSchema);

module.exports = authUserModel;
