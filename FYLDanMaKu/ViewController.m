//
//  ViewController.m
//  runBtn
//
//  Created by FuYunLei on 2017/6/29.
//  Copyright © 2017年 FuYunLei. All rights reserved.
//

#import "ViewController.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width     //屏幕宽度
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height    //屏幕高度


@interface ViewController ()
{
    CGFloat _speed;
}

@property(nonatomic,strong)NSTimer *timer;
@property (weak, nonatomic) IBOutlet UIView *viewContainer;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _speed = 4;
    /*
     只给出弹幕实现的一种思路,定时器的释放等,根据项目自己实现
     */
    [self start];
}

- (void)start{
//    [self.timer invalidate];
//    self.timer = nil;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(run) userInfo:nil repeats:YES];
}
//弹幕滚动
- (void)run{
    
    //这里可以判断,如果没弹幕了,就暂停定时器
    //然后 添加弹幕的时候在开启
    for (UILabel *label in self.viewContainer.subviews) {
        
        CGRect frame = label.frame;
        CGFloat x = frame.origin.x;
        x-=_speed/10;
        
        if (x < -300) {
            [label removeFromSuperview];
        }
        frame.origin.x = x;
        label.frame = frame;
    }
    
}
#pragma mark - 点击事件
//减速
- (IBAction)fast:(id)sender {
    _speed += 0.5;
    if (_speed > 8) {
        _speed = 8;
    }
}
//减速
- (IBAction)slow:(id)sender {
    _speed -= 0.5;
    if (_speed < 1) {
        _speed = 1;
    }
}
//随机弹幕
- (IBAction)randomText:(UIButton *)sender {
    NSString *str = @"中国好声音第三季上发斯蒂芬爱耍啊笨比操作撒地方啊发多少快乐高速都发送到的干撒安抚啊烦得很你你豆腐干上课呢日后isis跟你说你是 大师哥啊噶嘎达是个按到噶噶啊噶第三个撒不敢进口";
    
    NSInteger length = str.length;

    NSInteger count = random()%20;
    NSMutableString *mutStr = [NSMutableString string];
    while (count>0) {
        count--;
        [mutStr appendString:[str substringWithRange:NSMakeRange(arc4random()%length, 1)]];
    }
    
    [self addDanMaKuWithText:mutStr];

    
}
//自定义弹幕
- (IBAction)addOneDanMaKu:(UIButton *)sender {
    static int i = 0;
    i++;
    
    if (self.textField.text.length) {
        [self addDanMaKuWithText:[NSString stringWithFormat:@"%@-%i",_textField.text,i]];
    }else
    {
        [self addDanMaKuWithText:[NSString stringWithFormat:@"默认弹幕-%i",i]];
    }

}
#pragma mark - Tool
//添加一条弹幕
- (void)addDanMaKuWithText:(NSString *)text{
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.frame = CGRectMake(SCREEN_WIDTH, (arc4random()%8) * 15, 300, 20);
    label.textColor = [self randomColor];
    label.text = text;
    
    [self.viewContainer addSubview:label];
}

//随机颜色
- (UIColor*)randomColor
{
    CGFloat hue = (arc4random() %256/256.0);
    
    CGFloat saturation = (arc4random() %128/256.0) + 0.5;
    
    CGFloat brightness = (arc4random() %128/256.0) + 0.5;
    
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    
    return color;
}


@end
