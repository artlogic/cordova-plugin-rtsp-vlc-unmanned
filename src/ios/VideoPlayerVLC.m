//
//  VideoPlayerVLC.m
//  
//
//  Created by Yanbing Peng on 10/02/16.
//
//
#import "VideoPlayerVLC.h"


@implementation VideoPlayerVLC
-(void) play:(CDVInvokedUrlCommand *)command{
    
    
    CDVPluginResult *pluginResult = nil;
    NSString *urlString  = [command.arguments objectAtIndex:0];
    
    if (urlString != nil) {

        self.player = [[VideoPlayerVLCViewController alloc] init];
        self.player.urlString = urlString;
        
        [self.viewController presentViewController:self.player animated:YES completion:nil];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"started"];
        [self.commandDelegate sendPluginResult:pluginResult callbackId: command.callbackId];

    }
    else
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"invalid url"];
        [self.commandDelegate sendPluginResult:pluginResult callbackId: command.callbackId];
    }

}

-(void) stop:(CDVInvokedUrlCommand *)command{
        
	[self.player stop];

    // dismiss view from stack
    [self.viewController dismissViewControllerAnimated:YES completion:nil];
    
    CDVPluginResult *pluginResult = nil;
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"stopped"];
    [self.commandDelegate sendPluginResult:pluginResult callbackId: command.callbackId];
}

@end
