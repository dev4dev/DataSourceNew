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
#import "CompanyViewModel.h"

@interface ViewController () <UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) DataSourceImpl *dataSource;
@property (nonatomic, assign) NSInteger index;

@end

@implementation ViewController

- (void)viewDidLoad
{
	[super viewDidLoad];

	self.navigationItem.leftBarButtonItem = self.editButtonItem;

	self.dataSource = [[DataSourceImpl alloc] initWithTableView:self.tableView];
	self.dataSource.animation = UITableViewRowAnimationFade;
	self.dataSource.animated = YES;
	self.dataSource.editable = YES;
	[self.dataSource registerDataClass:[Person class]];
	[self.dataSource registerDataClass:[CompanyViewModel class]];

	[self.dataSource addSection:[self.dataSource createSection:^(id<DataSourceSection> section) {
		section.footerTitle = @"end of default section";
	}]];

	[self addNewObject];

//	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//		[self.dataSource deleteAllData];
//	});
}

- (Person *)createPerson
{
	Person *p = [Person new];
	p.name = [NSString stringWithFormat:@"Sponge Bob - %ld", self.index];
	++self.index;
	p.address = @"bottom of the sea";
	return p;
}

- (CompanyViewModel *)createCompany
{
	return [CompanyViewModel createWithName:@"Apple" address:@"Mars"];
}

- (void)addNewObject
{
	id<DataSourceCellConfigurable> obj;
	if (arc4random_uniform(1000) % 2 == 0) {
		obj = [self createPerson];
	} else {
		obj = [self createCompany];
	}
	[self.dataSource addObject:obj toSection:self.dataSource.sectionsCount - 1];
}

- (IBAction)onAddTap:(id)sender
{
	[self addNewObject];
}

- (IBAction)onAddSectionTap:(id)sender
{
	[self.dataSource addSection:[self.dataSource createSection:^(id<DataSourceSection> section) {
		section.headerTitle = @"Section";
	}]];
}

- (IBAction)onMoveTap:(id)sender
{
	[self.dataSource moveObjectFromIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] toIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] animated:NO];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
	[super setEditing:editing animated:animated];
	[self.tableView setEditing:editing animated:animated];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	id object = [self.dataSource objectAtIndexPath:indexPath];
	NSLog(@"Selected %@", object);
	[self.dataSource deleteObjectAtIndexPath:indexPath];
}

@end
