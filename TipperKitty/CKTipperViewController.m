//
//  CKTipperViewController.m
//  TipperKitty
//
//  Created by Christopher Kha on 5/5/14.
//  Copyright (c) 2014 Chris Kha Apps. All rights reserved.
//

#import "CKHAAppDelegate.h"
#import "CKTipperViewController.h"
#import "CKSettingsViewController.h"


@interface CKTipperViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;

- (IBAction)onTap:(id)sender;
- (void)updateValues;

@end

@implementation CKTipperViewController

#pragma mark - Initializer
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Tipper Kitty";

        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self selector:@selector(textFieldChanged:) name:@"UITextFieldTextDidChangeNotification" object:nil];
    }
    return self;
}

- (void)dealloc
{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self];
}

#pragma mark - View methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateValues];
    
    UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];
    settingsButton.tintColor = [UIColor blackColor];
    
    self.navigationItem.rightBarButtonItem = settingsButton;
    
    
    self.billTextField.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
//    NSLog(@"%@ view will appear", [self class]);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger tipControlDefault = [defaults integerForKey:CKTipControlDefaultKey];
    self.tipControl.selectedSegmentIndex = tipControlDefault;
    
    
    
}

- (void)viewDidAppear:(BOOL)animated {
//    NSLog(@"%@ view did appear", [self class]);
    // Refresh view when it appears
    [self updateValues];
}

- (void)viewWillDisappear:(BOOL)animated {
//    NSLog(@"%@ view will disappear", [self class]);
}

- (void)viewDidDisappear:(BOOL)animated {
//    NSLog(@"%@ view did disappear", [self class]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSArray *arrayOfString = [newString componentsSeparatedByString:@"."];
    if ([arrayOfString count] > 2) {
        // Return NO to keep the old string. Keep old string because more than one . makes the string invalid
        return NO;
    } else if ([arrayOfString count] == 2) {
        // decimal point is in the string. Don't allow decimal place to go longer than 2 characters
        NSString *decimalChars = arrayOfString[1];
        if (decimalChars.length > 2) {
            return NO;
        }
    }
    
    return YES;
}

#pragma mark - My Methods
- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    [self updateValues];
}

- (void)updateValues
{
    float billAmount = [self.billTextField.text floatValue];
    
    NSArray *tipValues = @[@(0.1), @(0.15), @(0.2)];
    float tipAmount = billAmount * [tipValues[self.tipControl.selectedSegmentIndex] floatValue];
    float totalAmount = billAmount + tipAmount;
    
    self.tipLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmount];
    self.totalLabel.text = [NSString stringWithFormat:@"$%0.2f", totalAmount];
}

- (void)onSettingsButton
{
    CKSettingsViewController *svc = [[CKSettingsViewController alloc] init];
    
    [self.navigationController pushViewController:svc animated:YES];
}

- (void)textFieldChanged:(id)sender
{
    [self updateValues];
}

@end
