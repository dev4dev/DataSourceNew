//
//  DataSourceImpl.h
//  DataSource2
//
//  Created by Alex Antonyuk on 7/5/16.
//  Copyright © 2016 Alex Antonyuk. All rights reserved.
//

@import UIKit;

#import "DataSource.h"
#import "DataSourceDefaultSection.h"

@interface DataSourceImpl : NSObject <DataSource>

@property (nonatomic, assign) UITableViewRowAnimation animation;
@property (nonatomic, assign) BOOL editable;

- (instancetype)initWithTableView:(UITableView *)tableView;

@end
