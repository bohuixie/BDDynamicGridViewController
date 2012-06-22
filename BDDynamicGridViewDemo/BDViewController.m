//
//  BDViewController.m
//  BDDynamicGridViewDemo
//
//  Created by Nor Oh on 6/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BDViewController.h"
#import "BDViewController+Private.h"
@interface BDViewController (){
    NSArray * _items;
}
@end

@implementation BDViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self _loadSampleDataWithCompletion:^(NSArray *images) {
        _items = images; 
        [self reloadData];
    }];
    self.rowHeight = 100;
    self.delegate = self;
    
    self.onLongPress = ^(UIView* view, NSInteger viewIndex){
        NSLog(@"Long press on %@, at %d", view, viewIndex);
    };

    self.onDoubleTap = ^(UIView* view, NSInteger viewIndex){
        NSLog(@"Double tap on %@, at %d", view, viewIndex);
    };

    
    [super viewDidLoad];
}


- (NSUInteger)numberOfViews
{
    return _items.count;
}

- (NSUInteger)numberOfColumns
{
    return 4;
}

- (CGRect) rectForImage:(UIImage*)image
{
    if (image.size.width > image.size.height) {
        return CGRectMake(0, 0, self.rowHeight * 3.0 / 2.0, self.rowHeight);
    }else {
        return CGRectMake(0, 0, self.rowHeight * 2.0 / 3.0, self.rowHeight);
    }
}

- (UIView *)viewAtIndex:(NSUInteger)index
{
    UIImage * img = [_items objectAtIndex:index];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    imageView.image = img;
    imageView.clipsToBounds = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.frame = [self rectForImage:img];
    return imageView;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    //Call super when overriding this method, in order to benefit from auto layout.
    [super shouldAutorotateToInterfaceOrientation:toInterfaceOrientation];
    return YES;
}

@end
