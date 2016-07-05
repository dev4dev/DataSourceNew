//
//  DataSourceCellConfigurable.h
//  DataSource2
//
//  Created by Alex Antonyuk on 7/5/16.
//  Copyright © 2016 Alex Antonyuk. All rights reserved.
//

@import UIKit;

@protocol DataSourceCellConfigurable <NSObject>

/**
 *	Cell Identifier is used to register cell classes or nibs in TableView, and for cells instantiation
 *
 *	@return Cell Identifier
 */
+ (NSString *)cellIdentifier;

/**
 *	Setup TableView by registering cell class or nib
 *
 *	@param tableView	Target TableView
 */
+ (void)setupTableView:(UITableView *)tableView;

/**
 *	Configure Cell with Data Object's data
 *	Use `self` to get data
 *
 *	@param cell			Cell
 *	@param indexPath	IndexPath of cell and object
 */
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end
