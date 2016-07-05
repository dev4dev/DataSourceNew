//
//  DataSource.h
//  DataSource2
//
//  Created by Alex Antonyuk on 7/5/16.
//  Copyright © 2016 Alex Antonyuk. All rights reserved.
//

@import UIKit;

@protocol DataSourceCellConfigurable;
@protocol DataSourceSection;

typedef void(^DataSourceSectionSetupBlock)(id<DataSourceSection> section);

@protocol DataSource <NSObject>

@property (nonatomic, strong, readonly) NSArray *data;
@property (nonatomic, assign, readonly) NSUInteger sectionsCount;
@property (nonatomic, assign) UITableViewRowAnimation animation;
@property (nonatomic, assign) BOOL animated;
@property (nonatomic, assign) BOOL editable;

- (void)addObject:(id)object toSection:(NSUInteger)section;
- (void)insertObject:(id)object atIndexPath:(NSIndexPath *)indexPath;
- (void)deleteObjectAtIndexPath:(NSIndexPath *)indexPath;
- (void)moveObjectFromIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)toIndexPath animated:(BOOL)animated;
- (id<DataSourceCellConfigurable>)objectAtIndexPath:(NSIndexPath *)indexPath;

- (void)addSection:(id<DataSourceSection>)section;
- (id<DataSourceSection>)createSection:(DataSourceSectionSetupBlock)block;
- (id<DataSourceSection>)sectionAtIndex:(NSUInteger)index;
- (void)deleteSectionAtIndex:(NSUInteger)index;

- (void)deleteAllData;

- (void)connectTableView:(UITableView *)tableView;
- (void)registerDataClass:(Class)dataClass;

@end
