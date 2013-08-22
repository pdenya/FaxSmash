//
//  UIView+PD.h
//  Inspect
//
//  Created by Paul Denya on 11/21/12.
//
//

#import <UIKit/UIKit.h>

@interface UIView (PD)

-(CGFloat)rightEdge;
-(CGFloat)bottomEdge;

-(void)addBlueBackground;
-(void)addBlueTableCellBackground;
-(void)addRedBorder;
- (void)addGreyBackground;

-(void)setxp:(CGFloat)percent;
-(void)setyp:(CGFloat)percent;
-(void)setwp:(CGFloat)percent;
-(void)sethp:(CGFloat)percent;

- (void)setw:(int)width;
- (void)seth:(int)height;
- (void)setx:(int)x;
- (void)sety:(int)y;

-(CGFloat)w;
-(CGFloat)h;
-(CGFloat)x;
-(CGFloat)y;

+ (UIImageView *) horizontalRule;
@end
