/**
 * @providesModule RNUTils
 * @flow
 */
'use strict';

var React = require('react-native');
var {
    NativeModules
    } = React;

var RCTUtilsManager = NativeModules.Utils;

var RNUtils = {
    sendSMS: function (message, phone_numbers, callback) {
        // Check the params
        if (phone_numbers.constructor !== Array) {
            if (callback) {
                callback("Error: phone_numbers need to be an array", false)
            }
        } else {
            RCTUtilsManager.sendSMS(message, phone_numbers, function (response) {
                if (response === "sent") {
                    if (callback) {
                        callback(null, true)
                    }
                } else if (response === "failed") {
                    if (callback) {
                        callback("Error: Message sent failed", false)
                    }
                } else {
                    if (callback) {
                        callback(null, null)
                    }
                }
            })
        }
    },
    openSettings: function () {
        RCTUtilsManager.openSettings()
    },
    isOnCall: function (callback) {
        RCTUtilsManager.isOnCall(function (response) {
            if (callback) {
                callback(response === "yes")
            }
        })
    }
};

module.exports = RNUtils;