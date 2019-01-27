//
//  SplashViewController.m
//  HelpYouDecide
//
//  Created by Young Bin Kim on 26/01/2019.
//  Copyright © 2019 YoungBin Kim. All rights reserved.
//

#import "SplashViewController.h"
#import "SharedConstants.h"

@interface SplashViewController ()

@property (nonatomic, weak) IBOutlet UIView *view;

@end

@implementation SplashViewController

- (UIColor *)fillColor {
    CGFloat val = 200.f;
    return [UIColor colorWithRed:val/255.f green:val/255.f blue:val/255.f alpha:1.f];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //TODO: Should I pull this out and move to view?
    [CATransaction begin];
    
    CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    [drawAnimation setFromValue:@(0.0)];
    [drawAnimation setDuration:2.f];
    [drawAnimation setToValue:@(1.0)];
    [drawAnimation setFillMode:kCAFillModeForwards];
    
    CABasicAnimation *fillAnimation = [CABasicAnimation animationWithKeyPath:@"fillColor"];
    [fillAnimation setFromValue:(id)[UIColor clearColor].CGColor];
    [fillAnimation setDuration:2.f];
    [fillAnimation setToValue:(id)[self fillColor].CGColor];
    [fillAnimation setFillMode:kCAFillModeForwards];


    CAShapeLayer *scaledLayer = [self layerWithScaledDownPath:[self ovalPath] forFrame:self.view.frame];
    [scaledLayer setStrokeColor:[UIColor colorWithRed:50.f/255.f green:50.f/255.f blue:50.f/255.f alpha:1.f].CGColor];
    [scaledLayer setLineCap:kCALineCapRound];
    [scaledLayer setLineWidth:17.f];
    [self.view.layer addSublayer:scaledLayer];

    __weak typeof(self) weakSelf = self;
    [CATransaction setCompletionBlock:^{
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:weakSelf forKey:ShowHesiationCollectionVCSegue];
        [weakSelf performSelector:@selector(performSegueWrapper:) withObject:dict afterDelay:1.0];
    }];
    [scaledLayer addAnimation:drawAnimation forKey:@"strokeEnd"];
    [CATransaction commit];
}

- (void)performSegueWrapper:(NSDictionary *)dict {
    [self performSegueWithIdentifier:dict.allKeys.firstObject sender:dict[ShowHesiationCollectionVCSegue]];
}

- (CAShapeLayer *)layerWithScaledDownPath:(UIBezierPath*)path forFrame:(CGRect)frame {
    CGRect boundingBox = CGPathGetBoundingBox(path.CGPath);
    CGFloat boundingBoxAspectRatio = boundingBox.size.width / boundingBox.size.height;
    CGFloat frameAspectRatio = frame.size.width / frame.size.height;
    CGFloat scaleFactor;
    if (boundingBoxAspectRatio > frameAspectRatio) {
        scaleFactor = frame.size.width / boundingBox.size.width;
    } else {
        scaleFactor = frame.size.height / boundingBox.size.height;
    }
    
    CGAffineTransform scaleTransform = CGAffineTransformIdentity;
    scaleTransform = CGAffineTransformScale(scaleTransform, scaleFactor, scaleFactor);
    scaleTransform = CGAffineTransformTranslate(scaleTransform, -CGRectGetMinX(boundingBox), -CGRectGetMinY(boundingBox));
    
    CGSize scaledSize = CGSizeApplyAffineTransform(boundingBox.size, CGAffineTransformMakeScale(scaleFactor, scaleFactor));
    CGSize centerOffset = CGSizeMake((CGRectGetWidth(frame)-scaledSize.width)/(scaleFactor*2.0),
                                     (CGRectGetHeight(frame)-scaledSize.height)/(scaleFactor*2.0));
    scaleTransform = CGAffineTransformTranslate(scaleTransform, centerOffset.width, -centerOffset.height);
    // End of "center in view" transformation code
    CGAffineTransform mirrorOverXOrigin = CGAffineTransformMakeScale(1.0f, -1.0f);
    CGAffineTransform translate = CGAffineTransformMakeTranslation(0, frame.size.height * 3);
    
    // Apply these transforms to the path
    [path applyTransform:mirrorOverXOrigin];
    [path applyTransform:translate];
    // Create a new shape layer and assign the new path
    
    CGPathRef scaledPath = CGPathCreateCopyByTransformingPath(path.CGPath, &scaleTransform);
    
    CAShapeLayer *scaledShapeLayer = [CAShapeLayer layer];
    scaledShapeLayer.path = scaledPath;
    scaledShapeLayer.fillColor = [UIColor colorWithRed:90.f green:90.f blue:90.f alpha:1.f].CGColor;
    
    return scaledShapeLayer;
}

//- (CABasicAnimation *)animationWithCompletionBlock:(void (^)(void))completionBlock {
//    [CATransaction begin];
//    CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//    [drawAnimation setFromValue:@0.0];
//    [drawAnimation setDuration:3.0];
//    [drawAnimation setToValue:@1.f];
//    [drawAnimation setFillMode:kCAFillModeForwards];
//    [CATransaction setCompletionBlock:completionBlock];
//    [CATransaction commit];
//    return drawAnimation;
//}

- (UIBezierPath *)ovalPath {
    UIBezierPath *ovalPath = [UIBezierPath bezierPath];
    [ovalPath moveToPoint:CGPointMake(828, 423)];
    [ovalPath addCurveToPoint:CGPointMake(427, 22) controlPoint1:CGPointMake(828, 201.53) controlPoint2:CGPointMake(648.47, 22)];
    [ovalPath addCurveToPoint:CGPointMake(26, 423) controlPoint1:CGPointMake(205.53, 22) controlPoint2:CGPointMake(26, 201.53)];
    [ovalPath addCurveToPoint:CGPointMake(427, 824) controlPoint1:CGPointMake(26, 644.47) controlPoint2:CGPointMake(295.53, 824)];
    [ovalPath addCurveToPoint:CGPointMake(828, 423) controlPoint1:CGPointMake(648.47, 824) controlPoint2:CGPointMake(828, 644.47)];
    [ovalPath closePath];
    [ovalPath moveToPoint:CGPointMake(778, 423)];
    [ovalPath addCurveToPoint:CGPointMake(427, 72) controlPoint1:CGPointMake(778, 229.15) controlPoint2:CGPointMake(620.85, 72)];
    [ovalPath addCurveToPoint:CGPointMake(76, 423) controlPoint1:CGPointMake(233.15, 72) controlPoint2:CGPointMake(76, 229.15)];
    [ovalPath addCurveToPoint:CGPointMake(427, 774) controlPoint1:CGPointMake(76, 616.85) controlPoint2:CGPointMake(233.15, 774)];
    [ovalPath addCurveToPoint:CGPointMake(778, 423) controlPoint1:CGPointMake(620.85, 774) controlPoint2:CGPointMake(778, 616.85)];
    [ovalPath closePath];
    [ovalPath moveToPoint:CGPointMake(402, 187)];
    [ovalPath addCurveToPoint:CGPointMake(351, 136) controlPoint1:CGPointMake(402, 158.83) controlPoint2:CGPointMake(379.17, 136)];
    [ovalPath addCurveToPoint:CGPointMake(300, 187) controlPoint1:CGPointMake(322.83, 136) controlPoint2:CGPointMake(300, 158.83)];
    [ovalPath addCurveToPoint:CGPointMake(351, 238) controlPoint1:CGPointMake(300, 215.17) controlPoint2:CGPointMake(322.82, 238)];
    [ovalPath addCurveToPoint:CGPointMake(402, 187) controlPoint1:CGPointMake(379.17, 238) controlPoint2:CGPointMake(402, 215.17)];
    [ovalPath closePath];
    [ovalPath moveToPoint:CGPointMake(641.53, 452.71)];
    [ovalPath addCurveToPoint:CGPointMake(539.02, 344.47) controlPoint1:CGPointMake(615.7, 381.73) controlPoint2:CGPointMake(569.8, 333.27)];
    [ovalPath addCurveToPoint:CGPointMake(530.07, 493.28) controlPoint1:CGPointMake(508.24, 355.68) controlPoint2:CGPointMake(504.23, 422.3)];
    [ovalPath addCurveToPoint:CGPointMake(632.58, 601.52) controlPoint1:CGPointMake(555.9, 564.27) controlPoint2:CGPointMake(601.8, 612.73)];
    [ovalPath addCurveToPoint:CGPointMake(641.53, 452.71) controlPoint1:CGPointMake(663.36, 590.32) controlPoint2:CGPointMake(667.37, 523.7)];
    [ovalPath closePath];
    [ovalPath moveToPoint:CGPointMake(354.01, 502.54)];
    [ovalPath addCurveToPoint:CGPointMake(249.98, 390.12) controlPoint1:CGPointMake(327.34, 429.25) controlPoint2:CGPointMake(288.76, 378.92)];
    [ovalPath addCurveToPoint:CGPointMake(242.55, 543.11) controlPoint1:CGPointMake(219.2, 401.32) controlPoint2:CGPointMake(215.87, 469.82)];
    [ovalPath addCurveToPoint:CGPointMake(346.58, 655.52) controlPoint1:CGPointMake(269.22, 616.4) controlPoint2:CGPointMake(315.8, 666.73)];
    [ovalPath addCurveToPoint:CGPointMake(354.01, 502.54) controlPoint1:CGPointMake(377.36, 644.32) controlPoint2:CGPointMake(380.69, 575.83)];
    [ovalPath closePath];
    [ovalPath moveToPoint:CGPointMake(928, 671)];
    [ovalPath addCurveToPoint:CGPointMake(877, 620) controlPoint1:CGPointMake(928, 642.83) controlPoint2:CGPointMake(905.17, 620)];
    [ovalPath addCurveToPoint:CGPointMake(826, 671) controlPoint1:CGPointMake(848.83, 620) controlPoint2:CGPointMake(826, 642.83)];
    [ovalPath addCurveToPoint:CGPointMake(877, 722) controlPoint1:CGPointMake(826, 699.17) controlPoint2:CGPointMake(848.83, 722)];
    [ovalPath addCurveToPoint:CGPointMake(928, 671) controlPoint1:CGPointMake(905.17, 722) controlPoint2:CGPointMake(928, 699.17)];
    [ovalPath closePath];
    [ovalPath moveToPoint:CGPointMake(1027.63, 936.42)];
    [ovalPath addCurveToPoint:CGPointMake(910.92, 757.3) controlPoint1:CGPointMake(998.58, 828.01) controlPoint2:CGPointMake(946.33, 747.82)];
    [ovalPath addCurveToPoint:CGPointMake(899.4, 970.77) controlPoint1:CGPointMake(875.51, 766.79) controlPoint2:CGPointMake(870.35, 862.37)];
    [ovalPath addCurveToPoint:CGPointMake(1016.11, 1149.89) controlPoint1:CGPointMake(928.45, 1079.18) controlPoint2:CGPointMake(980.7, 1159.37)];
    [ovalPath addCurveToPoint:CGPointMake(1027.63, 936.42) controlPoint1:CGPointMake(1051.52, 1140.4) controlPoint2:CGPointMake(1056.68, 1044.82)];
    [ovalPath closePath];
    
    return ovalPath;

}

@end
