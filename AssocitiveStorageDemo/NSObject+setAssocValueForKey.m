//
//  NSObject+setAssocValueForKey.m
//
//  Created by Duncan Champney on 12/4/12.
//
//

#import "NSObject+setAssocValueForKey.h"

#pragma mark - Associations
enum {
  OBJC_ASSOCIATION_ASSIGN = 0,
  OBJC_ASSOCIATION_RETAIN_NONATOMIC = 1,
  OBJC_ASSOCIATION_COPY_NONATOMIC = 3,
  OBJC_ASSOCIATION_RETAIN = 01401,
  OBJC_ASSOCIATION_COPY = 01403
};

typedef uintptr_t objc_AssociationPolicy;
id objc_getAssociatedObject(id object, void *key);
void objc_setAssociatedObject(id object, void *key, id value, objc_AssociationPolicy policy);
void objc_removeAssociatedObjects(id object);


@implementation NSObject (setAssocValueForKey)

static const char associatedStorageKey;

//-----------------------------------------------------------------------------------------------------------
#pragma mark - class  methods
//-----------------------------------------------------------------------------------------------------------

+ (NSMutableDictionary *) associationDictionary;
{
  NSMutableDictionary *associationDictionary = objc_getAssociatedObject(self, (void*) &associatedStorageKey);
  if (!associationDictionary)
  {
    associationDictionary = [NSMutableDictionary dictionary];
    objc_setAssociatedObject(self, (void*) &associatedStorageKey, associationDictionary, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  }
  return associationDictionary;
}

//-----------------------------------------------------------------------------------------------------------

+ (void) setAssocValue: (NSObject *) value forKey: (NSString *) key;
{
  if (key.length == 0)
    return;
  NSMutableDictionary * associationDictionary = [self associationDictionary];
  if (!value)
    [associationDictionary removeObjectForKey: key];
  else
    [associationDictionary setValue: value forKey: key];
}

//-----------------------------------------------------------------------------------------------------------

+ (NSObject *) assocValueForKey: (NSString *) key;
{
  if (!key.length) return nil;
  
  NSMutableDictionary * associationDictionary = [self associationDictionary];
  
  return [associationDictionary objectForKey: key];
}

//-----------------------------------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------------------------------
#pragma mark - Instance methods
//-----------------------------------------------------------------------------------------------------------

- (NSMutableDictionary *) associationDictionary;
{
  NSMutableDictionary *associationDictionary = objc_getAssociatedObject(self, (void*) &associatedStorageKey);
  if (!associationDictionary)
  {
    associationDictionary = [NSMutableDictionary dictionary];
    objc_setAssociatedObject(self, (void*) &associatedStorageKey, associationDictionary, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  }
  return associationDictionary;
}

//-----------------------------------------------------------------------------------------------------------

- (void) setAssocValue: (NSObject *) value forKey: (NSString *) key;
{
  if (key.length == 0)
    return;
  NSMutableDictionary * associationDictionary = [self associationDictionary];
  if (!value)
    [associationDictionary removeObjectForKey: key];
  else
    [associationDictionary setValue: value forKey: key];
}

//-----------------------------------------------------------------------------------------------------------

- (NSObject *) assocValueForKey: (NSString *) key;
{
  if (!key.length) return nil;
  
  NSMutableDictionary * associationDictionary = [self associationDictionary];

  return [associationDictionary objectForKey: key];
}

//-----------------------------------------------------------------------------------------------------------

@end
