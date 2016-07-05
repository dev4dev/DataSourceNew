//
//  ViewController.m
//  DataSource2
//
//  Created by Alex Antonyuk on 7/5/16.
//  Copyright © 2016 Alex Antonyuk. All rights reserved.
//

#import "ViewController.h"
#import "DataSourceImpl.h"
#import "Person+DataSource.h"

@interface ViewController () <UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) DataSourceImpl *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad
{
	[super viewDidLoad];


	self.dataSource = [[DataSourceImpl alloc] initWithTableView:self.tableView];
	self.dataSource.animation = UITableViewRowAnimationFade;
	self.dataSource.editable = YES;
	[self.dataSource registerDataClass:[Person class]];

	[self.dataSource addSection:[self.dataSource createSection:^(id<DataSourceSection> section) {
		section.footerTitle = @"end of default section";
	}]];

	[self.dataSource addObject:[self createPerson] toSection:0];
}

- (Person *)createPerson
{
	Person *p = [Person new];
	p.name = @"Sponge Bob";
	p.address = @"bottom of the sea";
	return p;
}

- (IBAction)onAddTap:(id)sender
{
	[self.dataSource addObject:[self createPerson] toSection:self.dataSource.sectionsCount - 1];
}

- (IBAction)onAddSectionTap:(id)sender
{
	[self.dataSource addSection:[self.dataSource createSection:^(id<DataSourceSection> section) {
		section.headerTitle = @"Section";
	}]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	id object = [self.dataSource objectAtIndexPath:indexPath];
	NSLog(@"Selected %@", object);
	[self.dataSource deleteObjectAtIndexPath:indexPath];
}

@end
