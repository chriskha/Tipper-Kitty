//
//  CKSettingsViewController.m
//  TipperKitty
//
//  Created by Christopher Kha on 5/5/14.
//  Copyright (c) 2014 Chris Kha Apps. All rights reserved.
//

#import "CKHAAppDelegate.h"
#import "CKSettingsViewController.h"
#import "CKTipperViewController.h"

@interface CKSettingsViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipDefaultControl;
@end

@implementation CKSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
//    NSLog(@"%@ view will appear", [self class]);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger defaultValue = [defaults integerForKey:CKTipControlDefaultKey];
    // If key does not exist, defaultValue = 0
    self.tipDefaultControl.selectedSegmentIndex = defaultValue;

    
}

- (void)viewDidAppear:(BOOL)animated {
//    NSLog(@"%@ view did appear", [self class]);
}

- (void)viewWillDisappear:(BOOL)animated {
//    NSLog(@"%@ view will disappear", [self class]);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:self.tipDefaultControl.selectedSegmentIndex forKey:CKTipControlDefaultKey];
    [defaults synchronize];
}

- (void)viewDidDisappear:(BOOL)animated {
//    NSLog(@"%@ view did disappear", [self class]);
}



@end
