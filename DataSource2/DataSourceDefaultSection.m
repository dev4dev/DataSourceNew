//
//  DataSourceDefaultSection.m
//  DataSource2
//
//  Created by Alex Antonyuk on 7/5/16.
//  Copyright © 2016 Alex Antonyuk. All rights reserved.
//

#import "DataSourceDefaultSection.h"

@interface DataSourceDefaultSection ()

@property (nonatomic, strong) NSMutableArray<id<DataSourceCellConfigurable>> *innerData;
@property (nonatomic, strong) dispatch_queue_t operationsQueue;

@end

@implementation DataSourceDefaultSection

- (instancetype)init
{
	if (self = [super init]) {
		_innerData = [NSMutableArray array];
		_operationsQueue = dispatch_queue_create("me.antonyuk.dataSource.section.operations", DISPATCH_QUEUE_SERIAL);
	}

	return self;
}

- (NSUInteger)index
{
	return [self.delegate indexOfDataSourceSection:self];
}

- (NSArray *)objects
{
	return [self.innerData copy];
}

- (NSIndexPath *)indexPathWithRow:(NSUInteger)row
{
	return [NSIndexPath indexPathForRow:row inSection:[self index]];
}

#pragma mark - DataSource Section

- (NSIndexPath *)addObject:(id<DataSourceCellConfigurable>)object
{
	if (!object) {
		return nil;
	}

	__block NSIndexPath *indexPath;
	dispatch_barrier_sync(self.operationsQueue, ^{
		NSUInteger row = self.innerData.count;
		[self.innerData addObject:object];
		indexPath = [self indexPathWithRow:row];
		[self.delegate dataSourceSection:self didAddObjectAtIndexPath:indexPath];
	});
	return indexPath;
}

- (NSIndexPath *)insertObject:(id<DataSourceCellConfigurable>)object atIndex:(NSUInteger)index
{
	if (!object || index > self.innerData.count) {
		return nil;
	}

	__block NSIndexPath *indexPath;
	dispatch_barrier_sync(self.operationsQueue, ^{
		[self.innerData insertObject:object atIndex:index];
		indexPath = [self indexPathWithRow:index];
		[self.delegate dataSourceSection:self didAddObjectAtIndexPath:indexPath];
	});
	return indexPath;
}

- (NSIndexPath *)deleteObjectAtIndex:(NSUInteger)index
{
	if (index >= self.innerData.count) {
		return nil;
	}

	__block NSIndexPath *indexPath;
	dispatch_barrier_sync(self.operationsQueue, ^{
		[self.innerData removeObjectAtIndex:index];
		indexPath = [self indexPathWithRow:index];
		[self.delegate dataSourceSection:self didDeleteObjectAtIndexPath:indexPath];
	});

	return indexPath;
}

- (NSIndexPath *)deleteObject:(id<DataSourceCellConfigurable>)object
{
	if (!object) {
		return nil;
	}

	NSUInteger index = [self.innerData indexOfObject:object];
	if (index == NSNotFound) {
		return nil;
	}

	__block NSIndexPath *indexPath;
	dispatch_barrier_sync(self.operationsQueue, ^{
		indexPath = [self indexPathWithRow:index];
		[self.delegate dataSourceSection:self didDeleteObjectAtIndexPath:indexPath];
		[self.innerData removeObjectAtIndex:index];

	});

	return indexPath;
}

- (id<DataSourceCellConfigurable>)objectAtIndex:(NSUInteger)index
{
	if (index >= self.innerData.count) {
		return nil;
	}

	return [self.innerData objectAtIndex:index];
}

- (NSUInteger)objectsCount
{
	return self.innerData.count;
}

- (void)silentOperation:(void(^)(id<DataSourceSection> section))block
{
	id<DataSourceSectionDelegate> delegate = self.delegate;
	self.delegate = nil;
	if (block) {
		block(self);
	}
	self.delegate = delegate;
}

@end
