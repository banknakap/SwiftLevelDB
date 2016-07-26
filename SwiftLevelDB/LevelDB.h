//
//  LevelDB.h
//  SwiftLevelDB
//
//  Created by Sedat Gökbek ÇİFTÇİ on 26/07/16.
//  Copyright © 2016 Sedat Gökbek ÇİFTÇİ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LevelDB : NSObject
- (instancetype) initWithDatabaseName:(NSString *) databaseName;
-(bool)deleteObject:(NSString *)key;
- (void) setObject:(id)object key:(NSString *)key;
- (id) getObject:(NSString *) key;
-(void) close;
@end
