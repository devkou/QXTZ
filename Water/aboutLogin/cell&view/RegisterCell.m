//
//  RegisterCell.m
//  Water
//
//  Created by KouHao on 15/12/20.
//  Copyright © 2015年 KH. All rights reserved.
//

#import "RegisterCell.h"
#import "QBTools.h"

@interface RegisterCell ()

@property (nonatomic, strong) UIView *line;

@end

@implementation RegisterCell


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self layoutAllComponents];
    }
    return self;
}

#pragma mark - Generate Properties
- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = RGBACOLOR(165, 165, 170, .6);
        _line.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _line;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.borderStyle = UITextBorderStyleNone;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _textField;
}

#pragma mark - Layout

- (void)layoutAllComponents {
    [self.contentView addSubview:self.line];
    [self.contentView addSubview:self.textField];
    
    //设置底线高1.0
    [_line autoSetDimension:ALDimensionHeight toSize:1.0];
    //设置输入框高度
    [_line autoSetDimension:ALDimensionHeight toSize:43.0];

    //距离父view边距
    ALEdgeInsets lineDefInsets = ALEdgeInsetsMake(0.0, 12.0, 0.0, 12.0);
    ALEdgeInsets textFieldDefInsets = ALEdgeInsetsMake(0.0, 12.0, 10.0, 12.0);

    [_line autoPinEdgesToSuperviewEdgesWithInsets:lineDefInsets excludingEdge:ALEdgeTop];
    [_textField autoPinEdgesToSuperviewEdgesWithInsets:textFieldDefInsets excludingEdge:ALEdgeBottom];

    //两个view之间距离也是20
    [_line autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_textField withOffset:0.0];
}

@end
