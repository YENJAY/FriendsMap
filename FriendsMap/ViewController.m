//
//  ViewController.m
//  NearFriends
//
//  Created by Wang on 15/3/3.
//  Copyright (c) 2015年 Wang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<BMKMapViewDelegate>
@property (weak, nonatomic) IBOutlet BMKMapView *mapView;
@property (strong,nonatomic) NSMutableArray *annotationArray;
@property (strong,nonatomic) NSMutableArray *array;
@end

@implementation ViewController
- (IBAction)reset:(id)sender {
    [self prepareData];
    [self.mapView removeAnnotations:self.annotationArray];
    [self addAnnotations];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.annotationArray = [NSMutableArray array];
    self.array = [NSMutableArray array];
    [self prepareData];
    self.mapView.delegate = self;
    [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(38, 117)];
    
}
- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    
    [self.annotationArray enumerateObjectsUsingBlock:^(AnnotationModel *obj, NSUInteger idx, BOOL *stop) {
        CGPoint point = [mapView convertCoordinate:CLLocationCoordinate2DMake(obj.latitude, obj.longitude) toPointToView:self.view];
        obj.x = point.x;
        obj.y = point.y;
    }];
    //然后顺序检测那些在距离范围内，如果在就合并成一个，把范围内的所有点替换成新的点，新的点是
}
-(void)prepareData{
    for (int i = 0; i<40; i++) {
        
        AnnotationModel *model = [[AnnotationModel alloc] init];
        model.index = i;
        model.userName = [NSString stringWithFormat:@"标题%d",i];
        model.latitude = 38.0 + (arc4random()%100/200.0) * ((NSInteger)arc4random() - (NSInteger)arc4random()>0?1:-1);
        model.longitude = 117.0 + (arc4random()%100/200.0) * ((NSInteger)arc4random() - (NSInteger)arc4random()>0?1:-1);
        [self.array addObject:model];
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self addAnnotations];
    
    
}
// Override
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        return newAnnotationView;
    }
    return nil;
}

-(void)addAnnotations{

    [self.annotationArray removeAllObjects];
    [self.array enumerateObjectsUsingBlock:^(AnnotationModel *obj, NSUInteger idx, BOOL *stop) {
        BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
        CLLocationCoordinate2D coor;
        coor.latitude = obj.latitude;
        coor.longitude = obj.longitude;
        annotation.coordinate = coor;
        annotation.title = obj.userName;
        [self.annotationArray addObject:annotation];
    }];
    [self.mapView addAnnotations:self.annotationArray];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
