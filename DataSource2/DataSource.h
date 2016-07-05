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

/**
 *	DataSource class is handy implementation of UITableViewDatasource protocol
 */
@protocol DataSource <NSObject>

/**
 *	All data from DataSource
 */
@property (nonatomic, strong, readonly) NSArray *data;

/**
 *	Sections Count
 */
@property (nonatomic, assign, readonly) NSUInteger sectionsCount;

/**
 *	TableView's animation Style
 */
@property (nonatomic, assign) UITableViewRowAnimation animation;

/**
 *	Whether operations are animated or not
 */
@property (nonatomic, assign) BOOL animated;

/**
 *	Is DataSource editable or not
 */
@property (nonatomic, assign) BOOL editable;

/**
 *	Add Data Object to the end ot the section at index
 *
 *	@param object	Data Object
 *	@param section	Section's Index
 */
- (void)addObject:(id)object toSection:(NSUInteger)section;

/**
 *	Insert Data Object at Indexpath
 *
 *	@param object		DataObject
 *	@param indexPath	IndexPath
 */
- (void)insertObject:(id)object atIndexPath:(NSIndexPath *)indexPath;

/**
 *	Delete Data Object at IndexPath
 *
 *	@param indexPath	IndexPath
 */
- (void)deleteObjectAtIndexPath:(NSIndexPath *)indexPath;

/**
 *	Move Data Object from source to destination IndexPath
 *
 *	@param sourceIndexPath	Source IndexPath
 *	@param toIndexPath			Destination IndexPath
 *	@param animated				Perform moving with animation or not
 */
- (void)moveObjectFromIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)toIndexPath animated:(BOOL)animated;

/**
 *	Returns object ar IndexPath
 *
 *	@param indexPath	Object's IndexPath
 *
 *	@return Returns Data Object or nil if IndexPath is out of bounds
 */
- (id<DataSourceCellConfigurable>)objectAtIndexPath:(NSIndexPath *)indexPath;

/**
 *	Add Section To DataSource
 *
 *	@param section	Section
 */
- (void)addSection:(id<DataSourceSection>)section;

/**
 *	Create new Section and accept section setup block, where you can setup title/footer header or other parameters
 *	Must be used in conjunction with `addSection:` method
 *
 *	@param block	Section setup block
 *
 *	@return Returns new Section
 */
- (id<DataSourceSection>)createSection:(DataSourceSectionSetupBlock)block;

/**
 *	Returne Section at index
 *
 *	@param index	Section's Index
 *
 *	@return Returns Section or nil if index is out of bounds
 */
- (id<DataSourceSection>)sectionAtIndex:(NSUInteger)index;

/**
 *	Delete Section at Index
 *
 *	@param index	Section's Index
 */
- (void)deleteSectionAtIndex:(NSUInteger)index;

/**
 *	Delete all data from DataSource
 */
- (void)deleteAllData;

/**
 *	Pair TtableView with this DataSource
 *
 *	@param tableView	TableView
 */
- (void)connectTableView:(UITableView *)tableView;

/**
 *	Register DataClass of Data Objects which will be stored in this DataSource
 *
 *	All Data Objects which will be displayed by DataSource should conform to `DataSourceCellConfigurable`
 *
 *	@param dataClass	Data Class which conforms to `DataSourceCellConfigurable`
 */
- (void)registerDataClass:(Class)dataClass;

@end
