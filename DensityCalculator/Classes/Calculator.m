//
//  Calculator.m
//  DensityCalculator
//
//  Created by Gene Backlin on 1/18/12.
//  Copyright (c) 2012 MariZack Consulting. All rights reserved.
//

#import "Calculator.h"

@implementation Calculator

@synthesize length;
@synthesize width;
@synthesize thickness;
@synthesize weight;
@synthesize frequency;
@synthesize minFrequency;
@synthesize maxFrequency;

@synthesize volume;
@synthesize density;
@synthesize radiationRatio;
@synthesize speedOfSoundValue;

- init {
    self = [super init];
    if (self) {
        // Custom initialization
        [self setRadiationRatio:[NSNumber numberWithDouble:0]];
        [self setSpeedOfSoundValue:[NSNumber numberWithDouble:0]];
        [self setFrequency:[NSNumber numberWithDouble:0]];
        [self setMinFrequency:[NSNumber numberWithDouble:32.70]];
        [self setMaxFrequency:[NSNumber numberWithDouble:4186.00]];
    }
    return self;
}

- (NSNumber *)calculateVolume {
    NSNumber *result = nil;
    double averageLength = [self averageValue:[self length]];
    double averageWidth = [self averageValue:[self width]];
    double averageThickness = [self averageValue:[self thickness]]/10;
    result = [NSNumber numberWithDouble:(averageLength * averageWidth * averageThickness)];
    
    [self setVolume:result];
    
    return result;
}

- (NSNumber *)calculateDensity {
    NSNumber *result = nil;
    
    double densityValue = [[self weight] doubleValue]/[[self volume] doubleValue];
    
    result = [NSNumber numberWithDouble:densityValue];
    
    [self setDensity:result];
    
    return result;
}

- (NSNumber *)calculateSpeedOfSound {
    NSNumber *result = nil;
    
    return result;
}

- (NSNumber *)calculateRadiationRatio {
    NSNumber *result = nil;
    
    return result;
}

- (double)averageValue:(NSArray *)values {
    double result = 0.0;
    double sum = 0.0;
    
    if(values) {
        for(NSNumber *value in values) {
            sum += [value doubleValue];
        }
        result = sum/[values count];
    }
    
    return result;
}

- (NSNumber *)averageLength {
    return [NSNumber numberWithDouble:[self averageValue:[self length]]];
}

- (NSNumber *)averageWidth {
    return [NSNumber numberWithDouble:[self averageValue:[self width]]];
}

- (NSNumber *)averageThickness {
    return [NSNumber numberWithDouble:[self averageValue:[self thickness]]];
}

#pragma mark - NSCoder methods

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:[self length] forKey:@"length"];
    [coder encodeObject:[self width] forKey:@"width"];
    [coder encodeObject:[self thickness] forKey:@"thickness"];
    [coder encodeObject:[self weight] forKey:@"weight"];
    [coder encodeObject:[self frequency] forKey:@"frequency"];
    [coder encodeObject:[self minFrequency] forKey:@"minFrequency"];
    [coder encodeObject:[self maxFrequency] forKey:@"maxFrequency"];
    [coder encodeObject:[self volume] forKey:@"volume"];
    [coder encodeObject:[self density] forKey:@"density"];
    [coder encodeObject:[self radiationRatio] forKey:@"radiationRatio"];
    [coder encodeObject:[self speedOfSoundValue] forKey:@"speedOfSoundValue"];
}

- (id)initWithCoder:(NSCoder *)coder {
    if (self = [super init]) {
		[self setLength:[coder decodeObjectForKey:@"length"]];
		[self setWidth:[coder decodeObjectForKey:@"width"]];
		[self setThickness:[coder decodeObjectForKey:@"thickness"]];
		[self setWeight:[coder decodeObjectForKey:@"weight"]];
		[self setFrequency:[coder decodeObjectForKey:@"frequency"]];
		[self setMinFrequency:[coder decodeObjectForKey:@"minFrequency"]];
		[self setMaxFrequency:[coder decodeObjectForKey:@"maxFrequency"]];
		[self setVolume:[coder decodeObjectForKey:@"volume"]];
		[self setDensity:[coder decodeObjectForKey:@"density"]];
		[self setRadiationRatio:[coder decodeObjectForKey:@"radiationRatio"]];
		[self setSpeedOfSoundValue:[coder decodeObjectForKey:@"speedOfSoundValue"]];
    }
    return self;
}


@end
