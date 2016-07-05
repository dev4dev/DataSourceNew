//
//  Person+DataSource.m
//  DataSource2
//
//  Created by Alex Antonyuk on 7/5/16.
//  Copyright © 2016 Alex Antonyuk. All rights reserved.
//

#import "Person+DataSource.h"
#import "PersonTableViewCell.h"

@implementation Person (DataSource)

+ (NSString *)cellIdentifier
{
	return @"PersonCell";
}

+ (void)setupTableView:(UITableView *)tableView
{
	[tableView registerClass:[PersonTableViewCell class] forCellReuseIdentifier:[self cellIdentifier]];
}

- (void)configureCell:(PersonTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
	cell.textLabel.text = self.name;
	cell.detailTextLabel.text = self.address;
}

@end
