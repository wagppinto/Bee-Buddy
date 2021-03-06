//
//  ApiaryViewController.m
//  Bee Buddy
//
//  Created by Eric Newman on 5/21/15.
//  Copyright (c) 2015 Eric Newman. All rights reserved.
//

#import "ApiaryViewController.h"
#import "HiveCollectionViewCell.h"
#import "Hive.h"
#import "NewHiveInApiaryViewController.h"
#import "HiveController.h"
#import "HiveViewController.h"

@interface ApiaryViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate>
@property (nonatomic, strong) NSArray *hiveArray;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;


@end

@implementation ApiaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.apiary.name;
    self.hiveArray = self.apiary.hives.allObjects;
    
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = .5;
    lpgr.delegate = self;
    [self.collectionView addGestureRecognizer:lpgr];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HiveCollectionViewCell *hiveCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reuseHiveCell" forIndexPath:indexPath];
    Hive *hive = self.hiveArray[indexPath.row];
    hiveCell.hiveLabel.text = hive.name;
    
    
    return hiveCell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.hiveArray.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
    
}

- (IBAction)addHive:(id)sender {
    //[self.apiary addHivesObject:hive];
    
    
}

-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer{
    if (gestureRecognizer.state != UIGestureRecognizerStateEnded) {
        CGPoint p = [gestureRecognizer locationInView:self.collectionView];
        
        NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:p];
        
        if (indexPath == nil) {
            NSLog(@"couldn't find index path");
        }else if (indexPath.section ==0){
            [[HiveController sharedInstance] removeHive:[HiveController sharedInstance].hives[indexPath.item]];
        }
    }
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
//    if ([segue.identifier isEqualToString:@"presentNewHive"]) {
//        NewHiveInApiaryViewController *newHive = segue.destinationViewController;
//        
//    }

    if([segue.identifier isEqualToString:@"apiaryHive"]){
        
        HiveViewController *hiveViewController = (HiveViewController *)segue.destinationViewController;
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:(UICollectionViewCell *)sender];
        Hive *hive = [HiveController sharedInstance].hives[indexPath.row];
        
        hiveViewController.hive = hive;
    }
}

@end
