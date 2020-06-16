//
//  NavbarViewController.m
//  Bingo


#import "ZJNavigationController.h"
#import "UIViewController+ZJInterfaceOrientation.h"
#import "ZJDeviceInfo.h"
#import "UIImage+ZJColor.h"
#import "UIColor+JKHEX.h"

@interface ZJNavigationController ()<UINavigationBarDelegate, UIGestureRecognizerDelegate, UINavigationControllerDelegate>

@property (nonatomic,strong) UIBarButtonItem *back;

@property (nonatomic,strong) UIBarButtonItem *whiteBack;

@property (nonatomic,assign) BOOL isCannotPush;

@end

@implementation ZJNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super initWithRootViewController:rootViewController]) {

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.interactivePopGestureRecognizer.delegate = self;
    self.delegate = self;
    self.navigationBar.translucent = YES;
    self.navigationBar.barTintColor = [UIColor whiteColor];
    self.isCannotPush = NO;
}

#pragma mark - UIGestureRecognizerDelegate Methods
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        if (self.viewControllers.count >= 2) {
            return [self.topViewController ZJ_interactivePopGestureEnabled];
        } else {
            return NO;
        }
    }
    return YES;
}

#pragma mark - UINavigationControllerDelegate Methods
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    self.isCannotPush = NO;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    //导航栏标题处理
    [self setNavigationBarHidden:[viewController ZJ_prefresHiddenNavigationBar] animated:animated];

    if (viewController.ZJ_titleTextAttributes) {
        [self.navigationBar setTitleTextAttributes:viewController.ZJ_titleTextAttributes];
    } else {
        if ([viewController ZJ_prefresHiddenNavigationBar] == NO)
        {
            if ([viewController ZJ_navType] == ZJNavTypeNormal) {
                [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
            }else if ([viewController ZJ_navType] == ZJNavTypeCustomColor){
                [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
                 self.navigationBar.tintColor = UIColor.whiteColor;//设置导航栏按钮颜色
            }else if ([viewController ZJ_navType] == ZJNavTypeClear){
                [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
            }
        }
    }
}

#pragma mark - overwrite Methods
/**
 该方法很重要！配合viewControllers里面各个vc的preferredStatusBarStyle方法。否则在右滑返回导航栏的时候会出现导航栏隐藏错乱的Bug
 */
- (UIViewController *)childViewControllerForStatusBarStyle{
    return self.topViewController;
}

- (UIViewController *)childViewControllerForStatusBarHidden{
    return self.topViewController;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count >= 1) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    if (viewController.navigationItem.leftBarButtonItems == nil && (self.viewControllers.count > 0 || [viewController ZJ_forceShowBackButtonItem] == YES) && [viewController ZJ_showBackButtonItem] == YES)
    {
        viewController.navigationItem.hidesBackButton = NO;
        if ([viewController ZJ_backBarButtonItems] != nil)
        {
            if ([viewController ZJ_backBarButtonItems].count > 0)
            {
                viewController.navigationItem.leftBarButtonItems = [viewController ZJ_backBarButtonItems];
            }else{
                viewController.navigationItem.leftBarButtonItems = nil;
                viewController.navigationItem.hidesBackButton = YES;
            }
        }else{
            if ([viewController ZJ_navType] == ZJNavTypeNormal) {
                viewController.navigationItem.leftBarButtonItems = @[self.back];
            }else if ([viewController ZJ_navType] == ZJNavTypeCustomColor){
                viewController.navigationItem.leftBarButtonItems = @[self.whiteBack];
            }else if ([viewController ZJ_navType] == ZJNavTypeClear){
                viewController.navigationItem.leftBarButtonItems = @[self.whiteBack];
            }
        }
    }else{
        viewController.navigationItem.hidesBackButton = YES;
    }
    
    
    if (self.isCannotPush == NO ) {
        if (animated) {
            self.isCannotPush = YES;
        }
        [super pushViewController:viewController animated:animated];
    }
    
    // 解决 iPhone X tabbar push 时会瞬间上移的问题
    if ([ZJDeviceInfo shareInstance].devicePlatform == ZJDeviceInfoPlatformiPhoneX ||
        [ZJDeviceInfo shareInstance].devicePlatform == ZJDeviceInfoPlatformiPhoneSimulator)
    {
        CGRect frame = self.tabBarController.tabBar.frame;
        frame.origin.y = CGRectGetHeight([UIScreen mainScreen].bounds) - frame.size.height;
        self.tabBarController.tabBar.frame = frame;
    }
}

#pragma mark - events Methods
- (void)backAction{
    if ([self.topViewController respondsToSelector:@selector(ZJ_backButtonAction)]) {
        [self.topViewController performSelector:@selector(ZJ_backButtonAction)];
    } else {
        [self popViewControllerAnimated:YES];
    }
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    switch (operation) {
        case UINavigationControllerOperationPush:
            return [toVC ZJ_pushAnimation];
            break;
        case UINavigationControllerOperationPop:
            return [fromVC ZJ_popAnimation];
            break;
        default:
            return nil;
            break;
    }
}

#pragma mark - overwrite Methods
- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    UIViewController *popToVC = self.topViewController.ZJ_previousViewController;
    
    if (popToVC && [self.viewControllers containsObject:popToVC]) {
        NSUInteger num = [self.viewControllers indexOfObject:popToVC];
        for (int i = (int)self.viewControllers.count - 1; i > num; i--) {
            UIViewController *vcWillPop = [self.viewControllers objectAtIndex:i];
            if ([vcWillPop respondsToSelector:@selector(ZJ_preDeallocInNav)]) {
                [vcWillPop performSelector:@selector(ZJ_preDeallocInNav)];
            }
        }
        
        [self popToViewController:self.topViewController.ZJ_previousViewController animated:animated];
        return nil;
    }
    
    if ([self.topViewController respondsToSelector:@selector(ZJ_preDeallocInNav)]) {
        [self.topViewController performSelector:@selector(ZJ_preDeallocInNav)];
    }
    return [super popViewControllerAnimated:animated];
}

#pragma mark - setter and getter Methods
- (UIBarButtonItem *)back {
    if (_back == nil) {
        UIButton  *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftButton setImage:[UIImage imageNamed:self.backImage ? self.backImage : @"back"]  forState:UIControlStateNormal];
        leftButton.backgroundColor = [UIColor clearColor];
        leftButton.frame = CGRectMake(0, 0, 30, 30);
        [leftButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        _back = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    }
    return _back;
}

- (UIBarButtonItem *)whiteBack
{
    if (_whiteBack == nil) {
        UIButton  *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        leftButton.frame = CGRectMake(0, 0, 30, 30);
        leftButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [leftButton setImage:[UIImage imageNamed:self.whiteBackImage ? self.whiteBackImage : @"whiteBack"]  forState:UIControlStateNormal];
        leftButton.backgroundColor = [UIColor clearColor];
        _whiteBack = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
        [leftButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _whiteBack;
}


- (void)setViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers {
    [super setViewControllers:viewControllers];
    if (viewControllers.count == 2) {
        UIViewController *vc = [viewControllers objectAtIndex:1];
        vc.hidesBottomBarWhenPushed = YES;
    }
}
@end
