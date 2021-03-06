// Copyright 2022 Google
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import "Private/FIRBundleUtil.h"

@implementation FIRBundleUtil

+ (NSArray *)relevantBundles {
  return @[ [NSBundle mainBundle], [NSBundle bundleForClass:[self class]] ];
}

+ (NSString *)optionsDictionaryPathWithResourceName:(NSString *)resourceName
                                        andFileType:(NSString *)fileType
                                          inBundles:(NSArray *)bundles {
  // Loop through all bundles to find the config dict.
  for (NSBundle *bundle in bundles) {
    NSString *path = [bundle pathForResource:resourceName ofType:fileType];
    // Use the first one we find.
    if (path) {
      return path;
    }
  }
  return nil;
}

+ (NSArray *)relevantURLSchemes {
  NSMutableArray *result = [[NSMutableArray alloc] init];
  for (NSBundle *bundle in [[self class] relevantBundles]) {
    NSArray *urlTypes = [bundle objectForInfoDictionaryKey:@"CFBundleURLTypes"];
    for (NSDictionary *urlType in urlTypes) {
      [result addObjectsFromArray:urlType[@"CFBundleURLSchemes"]];
    }
  }
  return result;
}

+ (BOOL)hasBundleIdentifier:(NSString *)bundleIdentifier inBundles:(NSArray *)bundles {
  for (NSBundle *bundle in bundles) {
    if ([bundle.bundleIdentifier isEqualToString:bundleIdentifier]) {
      return YES;
    }
  }
  return NO;
}

@end
