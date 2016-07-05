//
//  DataSourceDefaultSection.h
//  DataSource2
//
//  Created by Alex Antonyuk on 7/5/16.
//  Copyright © 2016 Alex Antonyuk. All rights reserved.
//

@import UIKit;
#import "DataSourceSection.h"

@interface DataSourceDefaultSection : NSObject <DataSourceSection>

@property (nonatomic, copy) NSString *headerTitle;
@property (nonatomic, copy) NSString *footerTitle;

@property (nonatomic, weak) id<DataSourceSectionDelegate> delegate;

@end
