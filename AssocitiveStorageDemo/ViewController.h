//
//  ViewController.h
//  AssocitiveStorageDemo
//
//  Created by Duncan Champney on 3/28/13.
//  Copyright (c) 2013 Duncan Champney. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^sheetDismissedBlock)(NSInteger);

@interface ViewController : UIViewController <UIActionSheetDelegate>

- (IBAction)showSheet1:(id)sender;
- (IBAction)showSheet2:(id)sender;

@end
