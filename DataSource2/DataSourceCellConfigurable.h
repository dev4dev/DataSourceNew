//
//  DataSourceCellConfigurable.h
//  DataSource2
//
//  Created by Alex Antonyuk on 7/5/16.
//  Copyright © 2016 Alex Antonyuk. All rights reserved.
//

@import UIKit;

@protocol DataSourceCellConfigurable <NSObject>

+ (NSString *)cellIdentifier;
+ (void)setupTableView:(UITableView *)tableView;
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end
