//
//  ViewController.m
//  DrawButton
//
//  Created by Mac on 14-3-11.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "ViewController.h"
#import "JBDrawView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet JBDrawView *drawView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.drawView updateProgressCircle:0.3];
//    [self.drawView performSelector:@selector(iiiii) withObject:nil afterDelay:10];
//    [self.drawView updateProgressCircle:0.2];
    [self.drawView addTarget:self action:@selector(iiiii) forControlEvents:UIControlEventTouchUpInside];
}
- (IBAction)dsdsd:(id)sender {
     [self.drawView updateProgressCircle:0.9];
}

- (void)iiiii
{
    NSLog(@"Hi");
//    [self.drawView updateProgressCircle:0.2];
}
@end
