# React Native Utils

RNUtils is a simple wrapper for all the native methods that are simple to execute. 
Currently there are these methods -

  - Send SMS (single/or group message available)
  - Open Settings for your app
  - Check if the user is on a call

Contribution is requested by all.
### Installation

```sh
$ npm install --save react-native-utils
```

```sh
In your project folder, Right Click ➜ Add files to <your project>
Go Into "node_modules/react-native-utils/rnutils" and select "RNUtils.h" and "RNUtils.m"
```
### Usage

```javascript
/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 */
'use strict';

var React = require('react-native');
var {
    AppRegistry,
    StyleSheet,
    Text,
    View,
    AlertIOS,
    } = React;
var RNUtils = require('react-native-utils')
var demo = React.createClass({
    sendText: function () {
        var phone_numbers = [
            "+18888888888",
            "+18885551212",
            "+15556106679"
        ]
        RNUtils.sendSMS("This is a test message", phone_numbers, function (err, res) {
            if (err) {
                AlertIOS.alert(
                    'Failed',
                    err,
                    [
                        {
                            text: 'Ok',
                        }
                    ]
                )
            } else {
                    AlertIOS.alert(
                        res ? 'Message Sent' : "User Cancelled",
                        "No failure occurred.",
                        [
                            {
                                text: 'Ok',
                            }
                        ]
                    )
            }
        })
    },
    checkOnCall: function(){
        RNUtils.isOnCall(function(res){
            AlertIOS.alert(
                res ? "On Call" : "Not On Call",
                "",
                [
                    {
                        text: 'Ok'
                    },
                ])
        })
    },
    render: function () {
        return (
            <View style={styles.container}>
                <Text style={styles.welcome} onPress={()=>RNUtils.openSettings()}>
                    Open Settings
                </Text>
                <Text style={styles.welcome} onPress={()=>this.sendText()}>
                    Send Text to 3 people
                </Text>
                <Text style={styles.welcome} onPress={()=>this.checkOnCall()}>
                    Check if person is on Call
                </Text>
            </View>
        );
    }
});

var styles = StyleSheet.create({
    container: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
        backgroundColor: '#F5FCFF',
    },
    welcome: {
        fontSize: 20,
        textAlign: 'center',
        margin: 10,
    },
    instructions: {
        textAlign: 'center',
        color: '#333333',
        marginBottom: 5,
    },
});

AppRegistry.registerComponent('demo', () => demo);

```
### Version
1.0.1

License
----

MIT


**Free Software, Hell Yeah!**

