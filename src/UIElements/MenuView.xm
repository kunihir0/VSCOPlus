#import "src/VscoPlus.h"

@implementation VscoPlusMenuView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.15 alpha:0.95];
        self.layer.cornerRadius = 12.0;
        self.translatesAutoresizingMaskIntoConstraints = NO;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    UIStackView *mainStack = [[UIStackView alloc] init];
    mainStack.axis = UILayoutConstraintAxisVertical;
    mainStack.spacing = 20;
    mainStack.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:mainStack];

    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"Vsco+ Menu";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [mainStack addArrangedSubview:titleLabel];

    UIStackView *flexRow = [[UIStackView alloc] init];
    flexRow.axis = UILayoutConstraintAxisHorizontal;
    flexRow.alignment = UIStackViewAlignmentCenter;
    
    UILabel *flexLabel = [[UILabel alloc] init];
    flexLabel.text = @"Enable FLEX";
    flexLabel.textColor = [UIColor whiteColor];
    [flexRow addArrangedSubview:flexLabel];

    UISwitch *flexSwitch = [[UISwitch alloc] init];
    [flexSwitch setOn:isFlexEnabled()];
    [flexSwitch addTarget:self action:@selector(toggleFlex:) forControlEvents:UIControlEventValueChanged];
    [flexRow addArrangedSubview:flexSwitch];
    [mainStack addArrangedSubview:flexRow];

    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [closeButton setTitle:@"Close" forState:UIControlStateNormal];
    [closeButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    [closeButton setTintColor:[UIColor whiteColor]];
    closeButton.backgroundColor = [UIColor colorWithWhite:0.3 alpha:1.0];
    closeButton.layer.cornerRadius = 8.0;
    [closeButton addTarget:self action:@selector(closeMenu) forControlEvents:UIControlEventTouchUpInside];
    [mainStack addArrangedSubview:closeButton];

    [NSLayoutConstraint activateConstraints:@[
        [mainStack.topAnchor constraintEqualToAnchor:self.topAnchor constant:20],
        [mainStack.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-20],
        [mainStack.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:20],
        [mainStack.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-20],
        [closeButton.heightAnchor constraintEqualToConstant:44]
    ]];
}

- (void)toggleFlex:(UISwitch *)sender {
    setFlexEnabled(sender.isOn);
    if (sender.isOn) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[%c(FLEXManager) sharedManager] showExplorer];
        });
    }
}

- (void)closeMenu {
    if (self.presentingButton) {
        [self.presentingButton setHidden:NO];
    }
    [self.superview removeFromSuperview];
}
@end