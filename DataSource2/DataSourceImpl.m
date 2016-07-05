//
//  DataSourceImpl.m
//  DataSource2
//
//  Created by Alex Antonyuk on 7/5/16.
//  Copyright © 2016 Alex Antonyuk. All rights reserved.
//

#import "DataSourceImpl.h"
#import "DataSourceSection.h"
#import "DataSourceDefaultSection.h"
#import "DataSourceCellConfigurable.h"

@interface DataSourceImpl () <UITableViewDataSource, DataSourceSectionDelegate>

@property (nonatomic, strong) NSMutableArray<id<DataSourceSection>> *sections;
@property (nonatomic, weak) UITableView *tableView;

@end

@implementation DataSourceImpl

- (instancetype)initWithTableView:(UITableView *)tableView
{
	if (self = [self init]) {
		[self connectTableView:tableView];
	}

	return self;
}

- (instancetype)init
{
	if (self = [super init]) {
		_sections = [NSMutableArray array];
		_animation = UITableViewRowAnimationNone;
	}

	return self;
}

- (NSArray *)data
{
	NSMutableArray *data = [NSMutableArray array];
	[self.sections enumerateObjectsUsingBlock:^(id<DataSourceSection>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		[data addObject:[obj objects]];
	}];
	return [data copy];
}

- (NSUInteger)sectionsCount
{
	return self.sections.count;
}

#pragma mark - DataSource

- (void)addObject:(id)object toSection:(NSUInteger)section
{
	if (!object) {
		return;
	}

	[self.tableView beginUpdates];
	id<DataSourceSection> s = [self sectionAtIndex:section];
	NSIndexPath *indexPath = [s addObject:object];
	[self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:self.animation];
	[self.tableView endUpdates];
}

- (void)insertObject:(id)object atIndexPath:(NSIndexPath *)indexPath
{
	if (!object) {
		return;
	}

	[self.tableView beginUpdates];
	id<DataSourceSection> s = [self sectionAtIndex:indexPath.section];
	NSIndexPath *ip = [s insertObject:object atIndex:indexPath.row];
	[self.tableView insertRowsAtIndexPaths:@[ip] withRowAnimation:self.animation];
	[self.tableView endUpdates];
}

- (void)deleteObjectAtIndexPath:(NSIndexPath *)indexPath
{
	[self.tableView beginUpdates];
	id<DataSourceSection> s = [self sectionAtIndex:indexPath.section];
	NSIndexPath *ip = [s deleteObjectAtIndex:indexPath.row];
	[self.tableView deleteRowsAtIndexPaths:@[ip] withRowAnimation:self.animation];
	[self.tableView endUpdates];
}

- (id<DataSourceCellConfigurable>)objectAtIndexPath:(NSIndexPath *)indexPath
{
	id<DataSourceSection> section = self.sections[indexPath.section];
	return [section objectAtIndex:indexPath.row];
}

- (void)addSection:(id<DataSourceSection>)section
{
	if (!section) {
		return;
	}

	[self.tableView beginUpdates];
	NSUInteger row = self.sections.count;
	[section setDelegate:self];
	[self.sections addObject:section];
	[self.tableView insertSections:[NSIndexSet indexSetWithIndex:row] withRowAnimation:self.animation];
	[self.tableView endUpdates];
}

- (id<DataSourceSection>)createSection:(DataSourceSectionSetupBlock)block
{
	id<DataSourceSection> section = [DataSourceDefaultSection new];
	if (block) {
		block(section);
	}
	return section;
}

- (id<DataSourceSection>)sectionAtIndex:(NSUInteger)index
{
	if (index >= self.sections.count) {
		return nil;
	}

	return self.sections[index];
}

- (void)connectTableView:(UITableView *)tableView
{
	tableView.dataSource = self;
	self.tableView = tableView;
}

- (void)registerDataClass:(Class)dataClass
{
	if ([dataClass conformsToProtocol:@protocol(DataSourceCellConfigurable)]) {
		[dataClass setupTableView:self.tableView];
	} else {
		NSAssert(NO, @"[DataSource Error]: Trying to register data class which doesn't conform to DataSourceCellConfigurable protocol");
	}
}

#pragma mark - Table DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	id<DataSourceSection> s = self.sections[section];
	return [s objectsCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	id<DataSourceCellConfigurable> item = [self objectAtIndexPath:indexPath];
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[[item class] cellIdentifier] forIndexPath:indexPath];
	[item configureCell:cell atIndexPath:indexPath];
	return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	id<DataSourceSection> s = [self sectionAtIndex:section];
	return s.headerTitle;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
	id<DataSourceSection> s = [self sectionAtIndex:section];
	return s.footerTitle;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
	return self.editable;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		[self deleteObjectAtIndexPath:indexPath];
	}
}

#pragma mark - Section Delegate

- (NSUInteger)indexOfDataSourceSection:(id<DataSourceSection>)section
{
	return [self.sections indexOfObject:section];
}

@end
