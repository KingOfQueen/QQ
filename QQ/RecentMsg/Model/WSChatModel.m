//
//  WSChatModel.m
//  QQ
//
//  Created by weida on 15/12/21.
//  Copyright © 2015年 weida. All rights reserved.
//  https://github.com/weida-studio/QQ

#import "WSChatModel.h"
#import "NSObject+CoreDataHelper.h"
#import "WSChatTextTableViewCell.h"
#import "WSChatTimeTableViewCell.h"
#import "WSChatVoiceTableViewCell.h"
#import "WSChatImageTableViewCell.h"

@implementation WSChatModel

+(NSString *)entityName
{
    return @"MsgHistory";
}

+(WSChatModel *)insertNewObjectInManagedObjectContext:(NSManagedObjectContext *)context
{
    return   [NSEntityDescription insertNewObjectForEntityForName:[self entityName] inManagedObjectContext:context];
}

+(NSEntityDescription *)entityInManagedObjectContext:(NSManagedObjectContext *)context
{
    return [NSEntityDescription entityForName:[self entityName] inManagedObjectContext:context];
}

+(NSUInteger)count
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [self entityInManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];    
    
    return [self.managedObjectContext countForFetchRequest:fetchRequest error:nil];
}

-(void)calculateSubViewsFrame:(CGFloat)width{
    switch ([self.chatCellType integerValue])
    {
        case WSChatCellType_Text:
        {
            if ([self.subViewsFrame objectForKey:@(width)]) {
                return;
            }else{
                NSMutableDictionary *newDict = [WSChatTextTableViewCell calculateSubViewsFramewithModel:self width:width].mutableCopy;
                [newDict addEntriesFromDictionary:self.subViewsFrame];
                self.subViewsFrame = newDict;
            }
        }
        case WSChatCellType_Time:
        {
           
            if ([self.subViewsFrame objectForKey:@(width)]) {
                return;
            }else{
                NSMutableDictionary *newDict = [WSChatTimeTableViewCell calculateSubViewsFramewithModel:self width:width].mutableCopy;
                [newDict addEntriesFromDictionary:self.subViewsFrame];
                self.subViewsFrame = newDict;
            }
            
        }
        case WSChatCellType_Audio:
        {
            
            if ([self.subViewsFrame objectForKey:@(width)]) {
                return;
            }else{
                NSMutableDictionary *newDict = [WSChatVoiceTableViewCell calculateSubViewsFramewithModel:self width:width].mutableCopy;
                [newDict addEntriesFromDictionary:self.subViewsFrame];
                self.subViewsFrame = newDict;
            }
            
        }
        case WSChatCellType_Image:
        {
            
            if ([self.subViewsFrame objectForKey:@(width)]) {
                return;
            }else{
                NSMutableDictionary *newDict = [WSChatImageTableViewCell calculateSubViewsFramewithModel:self width:width].mutableCopy;
                [newDict addEntriesFromDictionary:self.subViewsFrame];
                self.subViewsFrame = newDict;
            }
            
        }
        default:
            break;
    }
    
    self.height = self.subViewsFrame[@(width)][@"height"];
}

@end
