#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ActionMenu.h"

@interface WKContentView : UIView
- (NSString *)selectedText;
@end

@implementation UIResponder (GoogleAction)

- (void)doGoogleSearch:(id)sender
{
    NSString *selection = [self selectedTextualRepresentation];

    if (selection == nil && [self respondsToSelector:@selector(selectedText)]) { //Webkit
        //better method : [self isKindOfClass:[WKContentView class], but I have symbol error (´・ω・｀)
        selection = [self selectedText];
    }
    
    NSString *text = @"";
    if ([selection length] > 0) {
        text = [selection stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    
    NSString *url = @"https://www.google.com/search?q=";
    
    NSString *keyword = [url stringByAppendingString:text];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:keyword]];
}

- (BOOL)canGoogleSearch:(id)sender
{
	return YES;
}

+ (void)load
{
	id <AMMenuItem> menuItem = [[UIMenuController sharedMenuController]
                                registerAction:@selector(doGoogleSearch:)
                                title:@"Google"
                                canPerform:@selector(canGoogleSearch:)];
    
    menuItem.priority = 1000;
    
    if ([UIScreen mainScreen].scale == 1.0f) {
        menuItem.image = [UIImage imageWithContentsOfFile:@"/Library/ActionMenu/Plugins/GoogleSearchActionMenu.png"];
    } else if ([UIScreen mainScreen].scale == 2.0f) {
        menuItem.image = [UIImage imageWithContentsOfFile:@"/Library/ActionMenu/Plugins/GoogleSearchActionMenu@2x.png"];
    } else {
        menuItem.image = [UIImage imageWithContentsOfFile:@"/Library/ActionMenu/Plugins/GoogleSearchActionMenu@3x.png"];
    }
}

@end

