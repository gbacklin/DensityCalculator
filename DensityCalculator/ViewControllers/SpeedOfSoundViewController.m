//
//  SpeedOfSoundViewController.m
//  DensityCalculator
//
//  Created by Gene Backlin on 1/17/12.
//  Copyright (c) 2012 MariZack Consulting. All rights reserved.
//

#import "SpeedOfSoundViewController.h"
#import "SliderSettingsViewController.h"
#import "Calculator.h"
#import "PropertyList.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

static OSStatus RenderTone(
                           void *inRefCon,
                           AudioUnitRenderActionFlags 	*ioActionFlags,
                           const AudioTimeStamp 		*inTimeStamp,
                           UInt32 						inBusNumber,
                           UInt32 						inNumberFrames,
                           AudioBufferList 			*ioData)

{
    // Fixed amplitude is good enough for our purposes
    const double amplitude = 0.25;
    
    // Get the tone parameters out of the view controller
    SpeedOfSoundViewController *viewController =
    (__bridge SpeedOfSoundViewController *)inRefCon;
    double theta = viewController->theta;
    double theta_increment = 2.0 * M_PI * viewController->frequency / viewController->sampleRate;
    
    // This is a mono tone generator so we only need the first buffer
    const int channel = 0;
    Float32 *buffer = (Float32 *)ioData->mBuffers[channel].mData;
    
    // Generate the samples
    for (UInt32 frame = 0; frame < inNumberFrames; frame++)
    {
        buffer[frame] = sin(theta) * amplitude;
        
        theta += theta_increment;
        if (theta > 2.0 * M_PI)
        {
            theta -= 2.0 * M_PI;
        }
    }
    
    // Store the theta back in the view controller
    viewController->theta = theta;
    
    return noErr;
}

static void ToneInterruptionListener(void *inClientData, UInt32 inInterruptionState)
{
    SpeedOfSoundViewController *viewController =
    (__bridge SpeedOfSoundViewController *)inClientData;
    
    [viewController stop];
}

@implementation SpeedOfSoundViewController

@synthesize frequencyLabel;
@synthesize frequencySlider;
@synthesize playButton;
@synthesize averageLangthLabel;
@synthesize sliderMinimumLabel;
@synthesize sliderMaximumLabel;
@synthesize lengthLabel;
@synthesize thicknessLabel;
@synthesize currentValueLabel;

@synthesize calculator;
@synthesize tableViewCell;

@synthesize minFrequency;
@synthesize maxFrequency;
@synthesize currentFrequency;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView
 {
 }
 */

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[self frequencySlider] setValue:[[[self calculator] frequency] doubleValue]];
    [self sliderChanged:[self frequencySlider]];
    
    if([[[self calculator] frequency] doubleValue] < 35) {
        [[self calculator] setFrequency:[NSNumber numberWithDouble:440]];
        [self setCurrentFrequency:[[self calculator] frequency]]
        ;
        [[self frequencySlider] setValue:[[[self calculator] frequency] doubleValue]];
    }
    sampleRate = 44100;
    
    [self setMaxFrequency:[[self calculator] maxFrequency]];
    [self setMinFrequency:[[self calculator] minFrequency]];
    
    NSError *error = nil;
    //    BOOL activated = [[AVAudioSession sharedInstance] setActive:YES error:&error];
    NSError *setCategoryError = nil;
    
    AVAudioSession *session = [AVAudioSession sharedInstance];
    if (![session setCategory:AVAudioSessionCategoryPlayback
                  withOptions:AVAudioSessionCategoryOptionMixWithOthers
                        error:&setCategoryError]) {
        // handle error
        [session setActive:YES error:&error];
    }
    
    
    
    
    
    //	OSStatus result = AudioSessionInitialize(NULL, NULL, ToneInterruptionListener, (__bridge void *)self);
    //	if (result == kAudioSessionNoError)
    //	{
    //		UInt32 sessionCategory = kAudioSessionCategory_MediaPlayback;
    //		AudioSessionSetProperty(kAudioSessionProperty_AudioCategory, sizeof(sessionCategory), &sessionCategory);
    //	}
    //	AudioSessionSetActive(true);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    double minFreq = [[[self calculator] minFrequency] doubleValue];
    double maxFreq = [[[self calculator] maxFrequency] doubleValue];
    
    [[self frequencySlider] setMinimumValue:minFreq];
    [[self frequencySlider] setMaximumValue:maxFreq];
    
    [self setMaxFrequency:[NSNumber numberWithDouble:[[self frequencySlider] maximumValue]]];
    [self setMinFrequency:[NSNumber numberWithDouble:[[self frequencySlider] minimumValue]]];
    
    double minimumFrequency = [[self minFrequency] doubleValue];
    double maximumFrequency = [[self maxFrequency] doubleValue];
    
    double avgLength = [[self calculator] averageValue:[[self calculator] length]];
    double avgThickness = [[self calculator] averageValue:[[self calculator] thickness]]/10;
    double speedOfSound = [[[[self tableViewCell] detailTextLabel] text] doubleValue];
    
    [[self frequencyLabel] setText:[NSString stringWithFormat:@"%4.1f Hz", [[[self calculator] frequency] doubleValue]]];
    [[self sliderMinimumLabel] setText:[NSString stringWithFormat:@"%.2f", minimumFrequency]];
    [[self sliderMaximumLabel] setText:[NSString stringWithFormat:@"%.2f", maximumFrequency]];
    [[self lengthLabel] setText:[NSString stringWithFormat:@"%.2f", avgLength]];
    [[self thicknessLabel] setText:[NSString stringWithFormat:@"%.2f", avgThickness]];
    [[self currentValueLabel] setText:[NSString stringWithFormat:@"%.0f", speedOfSound]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    double speedOfSound = [[[self currentValueLabel] text] doubleValue];
    double density = [[[self calculator] density] doubleValue];
    double radiationRatio = speedOfSound / (density * 1000);
    
    double minFreq = [[[self calculator] minFrequency] doubleValue];
    double maxFreq = [[[self calculator] maxFrequency] doubleValue];
    double localFrequency = [[[self calculator] frequency] doubleValue];
    
    [[self frequencySlider] setMinimumValue:minFreq];
    [[self frequencySlider] setMaximumValue:maxFreq];
    [[self frequencySlider] setValue:localFrequency];
    
    [[self calculator] setFrequency:[NSNumber numberWithDouble:frequency]];
    [[self calculator] setMaxFrequency:[self maxFrequency]];
    [[self calculator] setMinFrequency:[self minFrequency]];
    
    [self setMaxFrequency:[NSNumber numberWithDouble:[[self frequencySlider] maximumValue]]];
    [self setMinFrequency:[NSNumber numberWithDouble:[[self frequencySlider] minimumValue]]];
    
    [[self calculator] setSpeedOfSoundValue:[NSNumber numberWithDouble:speedOfSound]];
    [[self calculator] setRadiationRatio:[NSNumber numberWithDouble:radiationRatio]];
    
    [[[self tableViewCell] detailTextLabel] setText:[NSString stringWithFormat:@"%.0f", speedOfSound]];
    
    NSMutableDictionary *newCalc = [[NSMutableDictionary alloc] initWithCapacity:1];
    [newCalc setObject:[self calculator] forKey:@"calculator"];
    [PropertyList writePropertyListFromDictionary:@"Calculator" dictionary:newCalc];
    
    [self stop];
}

- (void)viewDidUnload
{
    [self setFrequencyLabel:nil];
    [self setFrequencySlider:nil];
    [self setPlayButton:nil];
    [self setAverageLangthLabel:nil];
    [self setSliderMinimumLabel:nil];
    [self setSliderMaximumLabel:nil];
    [self setLengthLabel:nil];
    [self setThicknessLabel:nil];
    [self setCurrentValueLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    AudioSessionSetActive(false);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Tone Generatino

- (void)createToneUnit
{
    // Configure the search parameters to find the default playback output unit
    // (called the kAudioUnitSubType_RemoteIO on iOS but
    // kAudioUnitSubType_DefaultOutput on Mac OS X)
    AudioComponentDescription defaultOutputDescription;
    defaultOutputDescription.componentType = kAudioUnitType_Output;
    defaultOutputDescription.componentSubType = kAudioUnitSubType_RemoteIO;
    defaultOutputDescription.componentManufacturer = kAudioUnitManufacturer_Apple;
    defaultOutputDescription.componentFlags = 0;
    defaultOutputDescription.componentFlagsMask = 0;
    
    // Get the default playback output unit
    AudioComponent defaultOutput = AudioComponentFindNext(NULL, &defaultOutputDescription);
    NSAssert(defaultOutput, @"Can't find default output");
    
    // Create a new unit based on this that we'll use for output
    OSErr err = AudioComponentInstanceNew(defaultOutput, &toneUnit);
    NSAssert1(toneUnit, @"Error creating unit: %d", err);
    
    // Set our tone rendering function on the unit
    AURenderCallbackStruct input;
    input.inputProc = RenderTone;
    input.inputProcRefCon = (__bridge void *)self;
    err = AudioUnitSetProperty(toneUnit,
                               kAudioUnitProperty_SetRenderCallback,
                               kAudioUnitScope_Input,
                               0,
                               &input,
                               sizeof(input));
    NSAssert1(err == noErr, @"Error setting callback: %d", err);
    
    // Set the format to 32 bit, single channel, floating point, linear PCM
    const int four_bytes_per_float = 4;
    const int eight_bits_per_byte = 8;
    AudioStreamBasicDescription streamFormat;
    streamFormat.mSampleRate = sampleRate;
    streamFormat.mFormatID = kAudioFormatLinearPCM;
    streamFormat.mFormatFlags =
    kAudioFormatFlagsNativeFloatPacked | kAudioFormatFlagIsNonInterleaved;
    streamFormat.mBytesPerPacket = four_bytes_per_float;
    streamFormat.mFramesPerPacket = 1;
    streamFormat.mBytesPerFrame = four_bytes_per_float;
    streamFormat.mChannelsPerFrame = 1;
    streamFormat.mBitsPerChannel = four_bytes_per_float * eight_bits_per_byte;
    err = AudioUnitSetProperty (toneUnit,
                                kAudioUnitProperty_StreamFormat,
                                kAudioUnitScope_Input,
                                0,
                                &streamFormat,
                                sizeof(AudioStreamBasicDescription));
    NSAssert1(err == noErr, @"Error setting stream format: %d", err);
}

#pragma mark - Action methods

- (IBAction)togglePlay:(id)sender {
    if (toneUnit)
    {
        AudioOutputUnitStop(toneUnit);
        AudioUnitUninitialize(toneUnit);
        AudioComponentInstanceDispose(toneUnit);
        toneUnit = nil;
        
        [sender setTitle:NSLocalizedString(@"Play", nil) forState:0];
    }
    else
    {
        [self createToneUnit];
        
        // Stop changing parameters on the unit
        OSErr err = AudioUnitInitialize(toneUnit);
        NSAssert1(err == noErr, @"Error initializing unit: %d", err);
        
        // Start playback
        err = AudioOutputUnitStart(toneUnit);
        NSAssert1(err == noErr, @"Error starting unit: %d", err);
        
        [sender setTitle:NSLocalizedString(@"Stop", nil) forState:0];
    }
}

- (IBAction)sliderChanged:(UISlider *)sender {
    frequency = sender.value;
    double length = [[[self lengthLabel] text] doubleValue];
    double thickness = [[[self thicknessLabel] text] doubleValue];
    double speedOfSound = ((.98 * frequency * (length*length))/thickness)/100;
    
    [[self frequencyLabel] setText:[NSString stringWithFormat:@"%4.1f Hz", frequency]];
    [[self currentValueLabel] setText:[NSString stringWithFormat:@"%.0f", speedOfSound]];
    
    [[self calculator] setSpeedOfSoundValue:[NSNumber numberWithDouble:speedOfSound]];
    [[self calculator] setFrequency:[NSNumber numberWithDouble:frequency]];
    
    [self setMinFrequency:[NSNumber numberWithDouble:[[[self sliderMinimumLabel] text] doubleValue]]];
    [self setMaxFrequency:[NSNumber numberWithDouble:[[[self sliderMaximumLabel] text] doubleValue]]];
}

#pragma mark - Audio methods

- (void)stop
{
    if (toneUnit)
    {
        [self togglePlay:playButton];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"SliderSettings"])
    {
        SliderSettingsViewController* controller = segue.destinationViewController;
        [controller setSlider:[self frequencySlider]];
        [controller setCalculator:[self calculator]];
    }
}



@end
