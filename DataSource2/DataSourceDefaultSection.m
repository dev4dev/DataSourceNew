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

@end

@implementation DataSourceDefaultSection

- (instancetype)init
{
	if (self = [super init]) {
		_innerData = [NSMutableArray array];
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

	NSUInteger row = self.innerData.count;
	[self.innerData addObject:object];
	return [self indexPathWithRow:row];
}

- (NSIndexPath *)insertObject:(id<DataSourceCellConfigurable>)object atIndex:(NSUInteger)index
{
	if (!object || index >= self.innerData.count) {
		return nil;
	}

	[self.innerData insertObject:object atIndex:index];
	return [self indexPathWithRow:index];
}

- (NSIndexPath *)deleteObjectAtIndex:(NSUInteger)index
{
	if (index >= self.innerData.count) {
		return nil;
	}

	[self.innerData removeObjectAtIndex:index];
	return [self indexPathWithRow:index];
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
	[self.innerData removeObjectAtIndex:index];
	return [self indexPathWithRow:index];
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

@end
