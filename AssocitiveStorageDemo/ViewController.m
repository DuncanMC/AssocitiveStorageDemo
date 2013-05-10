//
//  ViewController.m
//  AssocitiveStorageDemo
//
//  Created by Duncan Champney on 3/28/13.
//  Copyright (c) 2013 Duncan Champney. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+setAssocValueForKey.h"

@interface ViewController ()

@end

@implementation ViewController



//-----------------------------------------------------------------------------------------------------------
#pragma mark - IBAction methods
//-----------------------------------------------------------------------------------------------------------


- (IBAction)showSheet1:(id)sender
{
  NSString *title = NSLocalizedString(@"This is action sheet 1", @"Title for action sheet 1");
  UIActionSheet *sheet = [self buildSheetWithTitle: title];

  //  //Define the block of code that will be run by the sheet delegate when the sheet is dismissed.
  sheetDismissedBlock theSheetDismissedBlock = ^void(NSInteger buttonIndex)
  {
    NSString *message = NSLocalizedString(@"You clicked button %d in sheet %d",
                                          @"'You clicked button x in sheet x' message");
    message = [NSString stringWithFormat: message, buttonIndex, 1];
    NSString *title = NSLocalizedString(@"You clicked a button", @"'You clicked a button' alert title");
    [self showAlertWithTitle:title message: message];
  };
  
  //Add the block of code to the sheet as an associated value
  [sheet setAssocValue: theSheetDismissedBlock forKey: @"sheetDismissedBlock"];
  
  [sheet showInView: self.view];


}

//-----------------------------------------------------------------------------------------------------------

- (IBAction)showSheet2:(id)sender
{
  NSString *title =               NSLocalizedString(@"This is action sheet 2", @"Title for action sheet 2");

  UIActionSheet *sheet = [self buildSheetWithTitle: title];
  //Define the block of code that will be run by the sheet delegate when the sheet is dismissed.
  sheetDismissedBlock theSheetDismissedBlock = ^void(NSInteger buttonIndex)
  {
    NSString *message = NSLocalizedString(@"You clicked button %d in sheet %d",
                                          @"'You clicked button x in sheet x' message");
    message = [NSString stringWithFormat: message, buttonIndex, 2];
    NSString *title = NSLocalizedString(@"You clicked a button", @"'You clicked a button' alert title");
    [self showAlertWithTitle:title message: message];
  };
  
  //Add the block of code to the sheet as an associated value
  [sheet setAssocValue: theSheetDismissedBlock forKey: @"sheetDismissedBlock"];
  
  [sheet showInView: self.view];
}

//-----------------------------------------------------------------------------------------------------------
#pragma mark - UIActionSheetDelegate  methods
//-----------------------------------------------------------------------------------------------------------
//This is the standard UIActionSheetDelegate method that gets called when the user dismisses an action sheet.
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
  //See if there is a block of code attached to the sheet using associative storage.
  sheetDismissedBlock theSheetDismissedBlock =
    (sheetDismissedBlock)[actionSheet assocValueForKey: @"sheetDismissedBlock"];
  
  //If there is a block, invoke it and pass it the button index.
  if (theSheetDismissedBlock)
    theSheetDismissedBlock(buttonIndex);
}

//-----------------------------------------------------------------------------------------------------------
#pragma mark - Misc instance methods
//-----------------------------------------------------------------------------------------------------------
//Create and return an action sheet with a specific title.

- (UIActionSheet *) buildSheetWithTitle: (NSString *) title
{
  //Build localized versions of our title and button strings
  NSString *button1String =       NSLocalizedString(@"This is Button 0", @"Title for Button 0");
  NSString *button2String =       NSLocalizedString(@"This is Button 1", @"Title for Button 1");
  NSString *button3String =       NSLocalizedString(@"This is Button 2", @"Title for Button 2");
  NSString *cancelButtonString =  NSLocalizedString(@"Cancel", @"cancel button string");
  
  UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle: title
                                                     delegate: self
                                            cancelButtonTitle: cancelButtonString
                                       destructiveButtonTitle: nil
                                            otherButtonTitles:
                          button1String,
                          button2String,
                          button3String,
                          nil];

  return sheet;
}

//-----------------------------------------------------------------------------------------------------------
//This message displays an alert with the specified title and message, and an OK button.

- (void) showAlertWithTitle: (NSString *) title message: (NSString *) message;
{
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle: title
                                                  message: message
                                                 delegate: nil
                                        cancelButtonTitle: NSLocalizedString(@"OK", @"OK button string")
                                        otherButtonTitles: nil];
  [alert show];
}

@end
