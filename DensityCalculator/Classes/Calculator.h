//
//  Calculator.h
//  DensityCalculator
//
//  Created by Gene Backlin on 1/18/12.
//  Copyright (c) 2012 MariZack Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Calculator : NSObject <NSCoding> {
    
}

@property (strong, nonatomic) NSArray *length;
@property (strong, nonatomic) NSArray *width;
@property (strong, nonatomic) NSArray *thickness;
@property (strong, nonatomic) NSNumber *weight;
@property (strong, nonatomic) NSNumber *frequency;
@property (strong, nonatomic) NSNumber *minFrequency;
@property (strong, nonatomic) NSNumber *maxFrequency;

@property (strong, nonatomic) NSNumber *volume;
@property (strong, nonatomic) NSNumber *density;
@property (strong, nonatomic) NSNumber *radiationRatio;
@property (strong, nonatomic) NSNumber *speedOfSoundValue;

- (NSNumber *)calculateVolume;
- (NSNumber *)calculateDensity;
- (NSNumber *)calculateSpeedOfSound;
- (NSNumber *)calculateRadiationRatio;
- (double)averageValue:(NSArray *)values;

- (NSNumber *)averageLength;
- (NSNumber *)averageWidth;
- (NSNumber *)averageThickness;


@end
