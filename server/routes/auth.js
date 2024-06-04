const express = require("express");
const router = express.Router();
const otpGenerator = require('otp-generator');
const AuthUser = require('../models/authUser');
const axios = require("axios").default;
require('dotenv').config();

// send otp
router.post('/login', async (req, res) => {
    const { phoneNumber } = req.body;

    console.log(phoneNumber);

    if (!phoneNumber) {
        return res.status(400).send('Phone Number is required');
    }

    // Generate a 6-digit numeric OTP
    const otp = otpGenerator.generate(6, {
        digits: true,
        lowerCaseAlphabets: false,
        upperCaseAlphabets: false,
        specialChars: false
    });
    console.log(otp);

    try {
        // Send OTP via MSG91

        var options = {
            method: 'POST',
            url: 'https://control.msg91.com/api/v5/otp',
            params: {
              template_id: process.env.MSG91_TEMPLATE_ID,
              mobile: phoneNumber,
              authkey: process.env.MSG91_AUTH_KEY
            },
            headers: {'Content-Type': 'application/JSON'},
            data: '{\n  "phoneNumber": "+8801909484884"\n}'
          };

        axios.request(options).then(function (response) {
            console.log(response.data);
        }).catch(function (error) {
            console.error(error);
        });
        console.log('otp sent');

        // Save OTP to database
        const otpEntry = new AuthUser({ phoneNumber, otp });
        await otpEntry.save();
        console.log('otp saved');

        // Send response once OTP is successfully sent and saved
        return res.json({ message: 'OTP saved successfully' });
    } catch (err) {
        console.error('Error sending OTP:', err.response ? err.response.data : err.message);
        return res.status(500).send('Verification failed');
    }
});

// verify-otp

router.post('/verify-otp', async (req, res) => {
    const { phoneNumber, otp } = req.body;

    if (!phoneNumber || !otp) {
        return res.status(400).send('Phone Number and otp are required');
    }

    try{
        const otpEntry = await AuthUser.findOne({phoneNumber, otp});
        
        if(!otpEntry){
            console.log('invalid otp or phoneNumber');
            return res.status(400).send('Invalid OTP or phoneNumber!');
        }
        console.log('otp verified');
        return res.status(200).send('OTP verification successful!');
    } catch(err) {
        console.error('Error verifying OTP:', err);
        return res.status(500).send('Internal server error');
    }
        
})

module.exports = router;
