//
//  SpeedOfSoundViewController.h
//  DensityCalculator
//
//  Created by Gene Backlin on 1/17/12.
//  Copyright (c) 2012 MariZack Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioUnit/AudioUnit.h>

@class Calculator;

@interface SpeedOfSoundViewController : UIViewController {
    AudioComponentInstance toneUnit;

@public
	double frequency;
	double sampleRate;
	double theta;

}

@property (weak, nonatomic) IBOutlet UILabel *frequencyLabel;
@property (weak, nonatomic) IBOutlet UISlider *frequencySlider;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UILabel *averageLangthLabel;
@property (weak, nonatomic) IBOutlet UILabel *sliderMinimumLabel;
@property (weak, nonatomic) IBOutlet UILabel *sliderMaximumLabel;
@property (weak, nonatomic) IBOutlet UILabel *lengthLabel;
@property (weak, nonatomic) IBOutlet UILabel *thicknessLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentValueLabel;

@property (strong, nonatomic) Calculator *calculator;
@property (weak, nonatomic) UITableViewCell *tableViewCell;

@property (strong, nonatomic) NSNumber *minFrequency;
@property (strong, nonatomic) NSNumber *maxFrequency;
@property (strong, nonatomic) NSNumber *currentFrequency;

- (IBAction)togglePlay:(id)sender;
- (IBAction)sliderChanged:(UISlider *)sender;
- (void)stop;

@end
