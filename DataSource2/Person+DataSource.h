//
//  Person+DataSource.h
//  DataSource2
//
//  Created by Alex Antonyuk on 7/5/16.
//  Copyright © 2016 Alex Antonyuk. All rights reserved.
//

#import "Person.h"
#import "DataSourceCellConfigurable.h"

@interface Person (DataSource) <DataSourceCellConfigurable>

@end
