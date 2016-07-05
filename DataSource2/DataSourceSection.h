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

/**
 *	Request section's index from DataSource
 *
 *	@param section	Section itself
 *
 *	@return Section's index
 */
- (NSUInteger)indexOfDataSourceSection:(id<DataSourceSection>)section;

/**
 *	Notifies delegate after data object insertion
 *
 *	@param section		Section itself
 *	@param indexPath	IndexPath of inserted object
 */
- (void)dataSourceSection:(id<DataSourceSection>)section didAddObjectAtIndexPath:(NSIndexPath *)indexPath;

/**
 *	Notifies delegate after data object deletion
 *
 *	@param section		Section itself
 *	@param indexPath	IndexPath of deleted object
 */
- (void)dataSourceSection:(id<DataSourceSection>)section didDeleteObjectAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol DataSourceSection <NSObject>

/**
 *	Setction's Title
 */
@property (nonatomic, copy) NSString *headerTitle;

/**
 *	Section's Footer
 */
@property (nonatomic, copy) NSString *footerTitle;

/**
 *	Data Objects Array
 */
@property (nonatomic, strong, readonly) NSArray<id<DataSourceCellConfigurable>> *objects;

/**
 *	Section's delegate
 */
@property (nonatomic, weak) id<DataSourceSectionDelegate> delegate;

/**
 *	Add Data Object to the section
 *
 *	@param object	Data Object
 *
 *	@return IndexPath of added object
 */
- (NSIndexPath *)addObject:(id<DataSourceCellConfigurable>)object;

/**
 *	Insert Data Object to the section
 *
 *	@param object	Data Object
 *	@param index	Target Index
 *
 *	@return IndexPath of inserted Object, nil if index is out of bounds
 */
- (NSIndexPath *)insertObject:(id<DataSourceCellConfigurable>)object atIndex:(NSUInteger)index;

/**
 *	Delete Data Object from the section by index
 *
 *	@param index	Object's index
 *
 *	@return IndexPath of deleted object
 */
- (NSIndexPath *)deleteObjectAtIndex:(NSUInteger)index;

/**
 *	Delete Data Object from the section
 *
 *	@param object	Data Object
 *
 *	@return IndexPath of deleted object
 */
- (NSIndexPath *)deleteObject:(id<DataSourceCellConfigurable>)object;

/**
 *	Returns Data Object at index
 *
 *	@param index	Object's index
 *
 *	@return Data Object or nil if index is out of bounds
 */
- (id)objectAtIndex:(NSUInteger)index;

/**
 *	Returns Data Objects count in the section
 *
 *	@return Objects count
 */
- (NSUInteger)objectsCount;

/**
 *	Executes all operations without notifing delegate about them
 *
 *	@param block	Block with add/delete operations
 */
- (void)silentOperation:(void(^)(id<DataSourceSection> section))block;

@end
