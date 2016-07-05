//
//  CompanyViewModel.m
//  DataSource2
//
//  Created by Alex Antonyuk on 7/5/16.
//  Copyright © 2016 Alex Antonyuk. All rights reserved.
//

#import "CompanyViewModel.h"
#import "CompanyTableViewCell.h"
#import "Company.h"

@interface CompanyViewModel ()

@property (nonatomic, strong) Company *model;

@end

@implementation CompanyViewModel

- (instancetype)initWithModel:(Company *)model
{
	if (self = [self init]) {
		_model = model;
	}

	return self;
}

+ (instancetype)createWithName:(NSString *)name address:(NSString *)address
{
	Company *c = [Company new];
	c.name = name;
	c.address = address;
	return [[self alloc] initWithModel:c];
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"%@: %@ - %@", [super description], self.model.name, self.model.address];
}

#pragma mark - Cell

+ (NSString *)cellIdentifier
{
	return @"CompanyCell";
}

+ (void)setupTableView:(UITableView *)tableView
{
	[tableView registerNib:[UINib nibWithNibName:@"CompanyTableViewCell" bundle:nil] forCellReuseIdentifier:[self cellIdentifier]];
}

- (void)configureCell:(CompanyTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
	cell.textLabel.text = self.model.name;
	cell.detailTextLabel.text = self.model.address;
}

@end
