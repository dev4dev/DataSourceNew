//
//  DataSourceSection.h
//  DataSource2
//
//  Created by Alex Antonyuk on 7/5/16.
//  Copyright © 2016 Alex Antonyuk. All rights reserved.
//

@import UIKit;

@protocol DataSourceSection;
@protocol DataSourceCellConfigurable;

@protocol DataSourceSectionDelegate <NSObject>

- (NSUInteger)indexOfDataSourceSection:(id<DataSourceSection>)section;

@end

@protocol DataSourceSection <NSObject>

@property (nonatomic, copy) NSString *headerTitle;
@property (nonatomic, copy) NSString *footerTitle;

@property (nonatomic, strong, readonly) NSArray<id<DataSourceCellConfigurable>> *objects;
@property (nonatomic, weak) id<DataSourceSectionDelegate> delegate;

- (NSIndexPath *)addObject:(id<DataSourceCellConfigurable>)object;
- (NSIndexPath *)insertObject:(id<DataSourceCellConfigurable>)object atIndex:(NSUInteger)index;
- (NSIndexPath *)deleteObjectAtIndex:(NSUInteger)index;
- (NSIndexPath *)deleteObject:(id<DataSourceCellConfigurable>)object;

- (id)objectAtIndex:(NSUInteger)index;
- (NSUInteger)objectsCount;

@end
