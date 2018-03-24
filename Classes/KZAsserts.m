//
//  KZAsserts.h
//  Pixle
//
//  Created by Krzysztof Zabłocki(@merowing_, merowing.info) on 07/2013.
//  Copyright (c) 2013 Pixle. All rights reserved.
//
#import "KZAsserts.h"

const NSUInteger KZAssertFailedAssertionCode = 13143542;

NSError *kza_NSErrorMake(NSString *message, NSUInteger code, NSDictionary *aUserInfo) {
  NSMutableDictionary *userInfo = [aUserInfo mutableCopy];
  userInfo[NSLocalizedDescriptionKey] = message;
  NSError *error = [NSError errorWithDomain:@"info.merowing.internal" code:code userInfo:userInfo];
  NSString *source = error.userInfo[@"Source"] ?: @"";
  NSString *function = error.userInfo[@"Function"] ?: @"";

  printf("%s\n", [NSString stringWithFormat: KZ_RED @"KZAsserts" KZ_CLEAR KZ_BLUE @" %@" KZ_CLEAR @" @ " KZ_GREEN @"%@" KZ_CLEAR KZ_RED @" | %@" KZ_CLEAR, function, source, message].UTF8String);
  return error;
}

static TKZAssertErrorFunction function = NULL;

@implementation KZAsserts

+ (void)registerErrorFunction:(TKZAssertErrorFunction)errorFunction
{
  function = errorFunction;
}

+ (TKZAssertErrorFunction)errorFunction
{
  if (!function) {
    [self registerErrorFunction:kza_NSErrorMake];
  }

  return function;
}

+ (BOOL)debugPass:(BOOL)shouldPass
{
  return shouldPass;
}

@end
