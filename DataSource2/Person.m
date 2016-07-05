//
//  Person.m
//  DataSource2
//
//  Created by Alex Antonyuk on 7/5/16.
//  Copyright © 2016 Alex Antonyuk. All rights reserved.
//

#import "Person.h"

@implementation Person

- (NSString *)description
{
	return [NSString stringWithFormat:@"%@: %@ - %@", [super description], self.name, self.address];
}

@end
