//
//  ViewController.m
//  滑动collectionview
//
//  Created by qugo on 16/10/14.
//  Copyright © 2016年 steven. All rights reserved.
//


#import "ViewController.h"
#import "MyCollectionViewCell.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIGestureRecognizerDelegate>
@property (nonatomic,strong)UICollectionView *collectionView;

@property (nonatomic,strong)NSString         *deleteItem;
/**
 CollectionView DataSource
 */
@property (nonatomic,strong)NSMutableArray   *dataSource;
@property (nonatomic,strong) NSIndexPath *indexPath;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createCollectionView];
    
}
- (void)createCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(50, 50);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 140) collectionViewLayout:layout];
    _collectionView.scrollEnabled = NO;
    _collectionView.layer.masksToBounds = NO;
    _collectionView.layer.zPosition = 2000;
    _collectionView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.8];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [_collectionView registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    [self.view addSubview:_collectionView];
    
    UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handlelongGesture:)];
    longGesture.delegate = self;
    [_collectionView addGestureRecognizer:longGesture];
    
    _dataSource = [NSMutableArray array];
    for (int i = 1; i <= 10; i++) {
        NSString *titleStr = [NSString stringWithFormat:@"%d",i];
        [_dataSource addObject:titleStr];
    }
    [_collectionView reloadData];
}
#pragma mark - UICollectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MyCollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    NSLog(@"--------------%@",_dataSource[indexPath.item]);
    cell.titleLab.text = _dataSource[indexPath.item];
    
    return cell;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString    *itemStr = _dataSource[indexPath.item];
    [_dataSource removeObject:itemStr];
    [_collectionView reloadData];
    
}

- (void)handlelongGesture:(UILongPressGestureRecognizer *)longGesture {
    
    
    CGPoint point = [longGesture locationInView:self.view];
    //    NSLog(@"中心点%@",NSStringFromCGPoint(point));
    
    switch (longGesture.state) {
        case UIGestureRecognizerStateBegan:{
            
            NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:[longGesture locationInView:self.collectionView]];
            if (indexPath == nil) {
                break;
            }
            _deleteItem = _dataSource[indexPath.item];
            [self.collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            [self.collectionView updateInteractiveMovementTargetPosition:[longGesture locationInView:self.collectionView]];
        }
            
            break;
        case UIGestureRecognizerStateEnded:
            [self.collectionView endInteractiveMovement];
            if (point.y > 150) {
                [_dataSource removeObject:_deleteItem];
                NSLog(@"删除后的数据源%@",_dataSource);
                [_collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
                
            }else{
                //                [self.collectionView endInteractiveMovement];
            }
            
            NSLog(@"%@",_dataSource);
            
            break;
        default:
            NSLog(@"啥时候走");
            [self.collectionView cancelInteractiveMovement];
            break;
    }
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath {
    
    NSLog(@"%@",destinationIndexPath);
    id objc = [_dataSource objectAtIndex:sourceIndexPath.item];
    //从资源数组中移除该数据
    [_dataSource removeObject:objc];
    //将数据插入到资源数组中的目标位置上
    [_dataSource insertObject:objc atIndex:destinationIndexPath.item];
    //    [_collectionView reloadData];
    
}





@end
