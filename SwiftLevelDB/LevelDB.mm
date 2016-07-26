//
//  LevelDB.mm
//  SwiftLevelDB
//
//  Created by Sedat Gökbek ÇİFTÇİ on 26/07/16.
//  Copyright © 2016 Sedat Gökbek ÇİFTÇİ. All rights reserved.
//

#import "LevelDB.h"
#include <iostream>
#include <sstream>
#include <string>

#import <leveldb/db.h>
#import <leveldb/options.h>
#import <leveldb/cache.h>
#import <leveldb/filter_policy.h>
#import <leveldb/write_batch.h>


#define SliceFromString(_string_) (Slice((char *)[_string_ UTF8String], [_string_ lengthOfBytesUsingEncoding:NSUTF8StringEncoding]))
#define StringFromSlice(_slice_) ([[NSString alloc] initWithBytes:_slice_.data() length:_slice_.size() encoding:NSUTF8StringEncoding])

using namespace std;
using namespace leveldb;


static id ObjectFromSlice(Slice v) {
    if (v.size() == NULL) {
        return nil;
    }
    NSData *data = [NSData dataWithBytes:v.data() length:v.size()];
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

@implementation LevelDB
{
    DB *db;
    ReadOptions readOptions;
    WriteOptions writeOptions;
}

- (instancetype) initWithDatabaseName:(NSString *) databaseName {
    if (self = [super init]) {
        [self createDB:databaseName];
    }
    return self;
}

- (void) createDB:(NSString *) databaseName {
    Options options;
    options.create_if_missing = true;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSError *error = nil;
    NSString *dbPath = [paths[0] stringByAppendingPathComponent:databaseName];
    NSString *lockFolderPath = [dbPath stringByAppendingPathComponent:@"LOCK"];
    
    NSFileManager *mgr = [NSFileManager defaultManager];
    if (![mgr fileExistsAtPath:lockFolderPath]) {
        NSURL *url = [NSURL fileURLWithPath:dbPath];
        [mgr createDirectoryAtURL:url withIntermediateDirectories:YES attributes:nil error:&error];
        
        if (error != nil) {
            NSLog(@"%@", error);
            return;
        }
    }
    
    Status status = DB::Open(options, [dbPath UTF8String], &self->db);
    if (false == status.ok()) {
        NSLog(@"ERROR: Unable to open/create Open Learning database.");
        cout << status.ToString();
    }
}

-(bool)deleteObject:(NSString *)key {
    ostringstream keySream;
    keySream << key.UTF8String;
    
    WriteOptions writeOptions;
    Status s = self->db->Delete(writeOptions, keySream.str());
    
    return s.ok();
}


- (void) setObject:(id)object key:(NSString *)key {
    NSData *dicData = [NSKeyedArchiver archivedDataWithRootObject:object];
    Slice k = SliceFromString(key);
    Slice v = Slice((const char *)[dicData bytes], (size_t)[dicData length]);
    Status status = self->db->Put(WriteOptions(), k, v);
    if (!status.ok()) {
        NSLog(@"Problem storing key/value pair in database: %s", status.ToString().c_str());
    }
}

- (id) getObject:(NSString *) key {
    string v_string;
    Slice k = SliceFromString(key);
    Status status = db->Get(readOptions, k, &v_string);
    
    if(!status.ok()) {
        if(!status.IsNotFound())
            NSLog(@"Problem retrieving value for key '%@' from database: %s", key, status.ToString().c_str());
    }
    
    return ObjectFromSlice(v_string);
}

-(void)close {
    delete self->db;
}


@end
