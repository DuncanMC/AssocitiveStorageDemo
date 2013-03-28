AssocitiveStorageDemo
=====================

A demo of using associative storage to add a code block to UIActionSheet objects that are invoked when the user clicks a button on the sheet.

This app demonstrates using associative storage to solve a common problem: Handling button clicks in UIActionSheets or UIAlertViews with a single didDismiss delegate method. (Scroll down for more.)

Normally you would have to write a common didDismiss delegate to handle button clicks in all the action sheets (or alert views) in your program, save a pointer to the alert view, and use it to figure out which alert view you were handling, then include code to handle the user action for each action sheet/alert separately. (Yuck!)

With associative storage, you can attach a code block to the action sheet or alert view, and then all your didDismiss method needs to do is check for a block and invoke it if it finds one.

Since the block is defined in the code that creates the action sheet/alert, it's easy to see what it is doing.

The app uses a trivial example of 2 buttons that invoke action sheets that are all but identical, named action sheet 1 and action sheet 2.

The code for each action sheet attaches a unique code block to that action sheet before invoking it, using a handy category of NSObject, NSObject (setAssocValueForKey), that I created that allows you to attach any arbitrary object to any other using associative storage.

To attach an object, you use the method setAssocValue:forKey, and to retrieve an associated object, you use the method assocValueForKey.

Since these methods are in a category of NSObject, they add these methods to ALL objects that are subclasses of NSObject.

Since the methods only add associative storage to an object if you use them, there is no overhead for using them other than a single global static const character that gets added to your program when you include the NSObject category.
