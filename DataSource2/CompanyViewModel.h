//
//  CompanyViewModel.h
//  DataSource2
//
//  Created by Alex Antonyuk on 7/5/16.
//  Copyright © 2016 Alex Antonyuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataSourceCellConfigurable.h"

@class Company;

@interface CompanyViewModel : NSObject <DataSourceCellConfigurable>

@property (nonatomic, strong, readonly) Company *model;

- (instancetype)initWithModel:(Company *)model;

+ (instancetype)createWithName:(NSString *)name address:(NSString *)address;

@end
