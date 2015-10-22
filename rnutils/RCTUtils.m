//
//  SMSSender.m
//  reactnativeutils
//
//  Created by Rishabh Mehan on 9/20/15.
//  Copyright © 2015 DareU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCTUtils.h"
#import <CoreTelephony/CTCallCenter.h>
#import <CoreTelephony/CTCall.h>
@interface RCTUtils ()

@property (nonatomic, strong) MFMessageComposeViewController *controller;
@property (nonatomic, strong) RCTResponseSenderBlock callback;

@end
@implementation RCTUtils

RCT_EXPORT_MODULE();

/***********************
 METHOD 1: sendSMS - method to send message (author: Rishabh Mehan)
 ***********************/
RCT_EXPORT_METHOD(sendSMS:(NSString *)bodyOfMessage recipientList:(NSArray *)recipients callback:(RCTResponseSenderBlock)callback)
{
    /**
     * A method to send sms to one or many contacts
     * @params bodyOfMessage the text that is to be sent.
     * @params recipients an array of numbers who are to be sent a SMS.
     * @params callback callback to send response to the caller
     */
    self.callback = callback;
    UIViewController *root = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] initWithNibName:nil bundle:nil];
    if([MFMessageComposeViewController canSendText])
    {
        controller.body = bodyOfMessage;
        controller.recipients = recipients;
        controller.messageComposeDelegate = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            [root presentViewController:controller animated:YES completion:nil];
        });
    }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [controller dismissViewControllerAnimated:YES completion:NULL];
    if (result == MessageComposeResultCancelled){
        self.callback(@[@"cancelled"]);
    } else if (result == MessageComposeResultSent){
        self.callback(@[@"sent"]);
    } else{
        self.callback(@[@"failed"]);
    }
}

/***********************
 METHOD 2: openSettings - method to open app settings directly (author: Rishabh Mehan)
 ***********************/

RCT_EXPORT_METHOD(openSettings)
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
}

/***********************
 METHOD 3: isOnCall - method to check if the person is on a call. (author: Rishabh Mehan)
 ***********************/

RCT_EXPORT_METHOD(isOnCall:(RCTResponseSenderBlock)callback)
{
    self.callback = callback;
    CTCallCenter *ctCallCenter = [[CTCallCenter alloc] init];
    if (ctCallCenter.currentCalls != nil)
    {
        NSArray* currentCalls = [ctCallCenter.currentCalls allObjects];
        for (CTCall *call in currentCalls)
        {
            if(call.callState == CTCallStateConnected)
            {
                self.callback(@[@"yes"]);
            }
        }
    } else {
        self.callback(@[@"no"]);
    }
}

@end