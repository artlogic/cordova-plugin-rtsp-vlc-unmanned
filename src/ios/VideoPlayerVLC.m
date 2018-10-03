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
        
        [self.viewController addChildViewController:self.player];

        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK  messageAsBool:true];
        [self.commandDelegate sendPluginResult:pluginResult callbackId: command.callbackId];
    }
    else
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"url.invalid"];
        [self.commandDelegate sendPluginResult:pluginResult callbackId: command.callbackId];
    }

}

-(void) stop:(CDVInvokedUrlCommand *) command {
    
    if (self.player != nil) {

        [self.player stop];

        // dismiss view from stack
        [self.player removeFromParentViewController];
        
        CDVPluginResult *pluginResult = nil;
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK  messageAsBool:true];
        [self.commandDelegate sendPluginResult:pluginResult callbackId: command.callbackId];

        self.player = nil;
    }
    
}

@end
