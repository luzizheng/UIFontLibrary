//
//  ViewController.m
//  UIFontCategory
//
//  Created by zizheng lu on 2020/9/28.
//

#import "ViewController.h"
#import "UIFontLibrary.h"
@interface ViewController ()
@property(nonatomic,strong)UILabel * lb;
@end

@implementation ViewController

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.lb sizeToFit];
    self.lb.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.lb = [[UILabel alloc] init];
    self.lb.font = [UIFont fontWithName:UIFontNamePingfangscSemibold size:28];

    self.lb.text = @"test font";
    [self.view addSubview:self.lb];

//    [self ceateCategoryFile];
//    [self createConstFile];
    
}

-(void)ceateCategoryFile
{
    NSString * clsName = @"UIFont";
    NSString * extName = @"Library";

    NSString * path_h = @"/Users/zizhenglu/Documents/Output/UIFont+Library.h";
    NSString * path_m = @"/Users/zizhenglu/Documents/Output/UIFont+Library.m";

    NSMutableString * h_string = [[NSMutableString alloc] init];
    NSMutableString * m_string = [[NSMutableString alloc] init];

    [h_string appendFormat:@"//\n//  %@+%@.h\n//  %@%@\n//\n//  Created by zizheng lu on 2020/9/28.\n//\n\n#import <UIKit/UIKit.h>\n\nNS_ASSUME_NONNULL_BEGIN\n\n@interface %@ (%@)\n",clsName,extName,clsName,extName,clsName,extName];
    [m_string appendFormat:@"//\n//  %@+%@.m\n//  %@%@\n//\n//  Created by zizheng lu on 2020/9/28.\n//\n\n#import \"%@+%@.h\"\n\n@implementation %@ (%@)\n",clsName,extName,clsName,extName,clsName,extName,clsName,extName];


    NSMutableArray * fontNamesArray = [NSMutableArray array];
    for (NSString * familyName in UIFont.familyNames) {
        [h_string appendFormat:@"\n#pragma mark - %@\n",familyName];
        [m_string appendFormat:@"\n#pragma mark - %@\n",familyName];
        for (NSString * fontName in [UIFont fontNamesForFamilyName:familyName]) {
            NSLog(@"\n%@",fontName);
            NSString * capitalizedString = [fontName capitalizedString];
            NSString * fontNameWithoutLine = [capitalizedString stringByReplacingOccurrencesOfString:@"-" withString:@""];
            [h_string appendFormat:@"+(UIFont *)fontWith%@:(CGFloat)fontSize;\n",fontNameWithoutLine];
            [m_string appendFormat:@"+(UIFont *)fontWith%@:(CGFloat)fontSize\n{\n    return [UIFont fontWithName:@\"%@\" size:fontSize];\n}\n",fontNameWithoutLine,fontName];
            [fontNamesArray addObject:fontNameWithoutLine];
        }
    }

    [h_string appendFormat:@"\n@end\n\n#pragma mark - Font Macro\n\n"];
    for (NSString * string in fontNamesArray) {
        [h_string appendFormat:@"#define kFont_%@(size) [UIFont fontWith%@:size]\n",string,string];
    }
    [h_string appendString:@"\nNS_ASSUME_NONNULL_END\n"];

    [m_string appendString:@"\n@end\n"];

    NSError * h_err = nil;
    NSError * m_err = nil;
    [h_string writeToFile:path_h atomically:YES encoding:NSUTF8StringEncoding error:&h_err];
    [m_string writeToFile:path_m atomically:YES encoding:NSUTF8StringEncoding error:&m_err];
    if (h_err) {
        NSLog(@"header 文件出错：%@",h_err.description);
    }
    if (m_err) {
        NSLog(@"implementation 文件出错：%@",m_err.description);
    }

    if (h_err == nil && m_err == nil) {
        NSLog(@"输出成功！");
    }
}

-(void)createConstFile
{
    NSString * clsName = @"UIFontNameConst";

    NSString * path_h = @"/Users/zizhenglu/Documents/Output/UIFontNameConst.h";
    NSString * path_m = @"/Users/zizhenglu/Documents/Output/UIFontNameConst.m";

    NSMutableString * h_string = [[NSMutableString alloc] init];
    NSMutableString * m_string = [[NSMutableString alloc] init];

    [h_string appendFormat:@"//\n//  %@.h\n//  UIFontLibrary\n//\n//  Created by zizheng lu on 2020/9/28.\n//\n\n#import <UIKit/UIKit.h>\n\n",clsName];
    [m_string appendFormat:@"//\n//  %@.m\n//  UIFontLibrary\n//\n//  Created by zizheng lu on 2020/9/28.\n//\n\n#import \"%@.h\"\n\n",clsName,clsName];


    NSMutableArray * fontNamesArray = [NSMutableArray array];
    for (NSString * familyName in UIFont.familyNames) {
        [h_string appendFormat:@"\n#pragma mark - %@\n",familyName];
        [m_string appendFormat:@"\n#pragma mark - %@\n",familyName];
        for (NSString * fontName in [UIFont fontNamesForFamilyName:familyName]) {
            NSLog(@"\n%@",fontName);
            NSString * capitalizedString = [fontName capitalizedString];
            NSString * fontNameWithoutLine = [capitalizedString stringByReplacingOccurrencesOfString:@"-" withString:@""];
            [h_string appendFormat:@"UIKIT_EXTERN NSString * const UIFontName%@;\n",fontNameWithoutLine];
            [m_string appendFormat:@"NSString * const UIFontName%@ = @\"%@\";\n",fontNameWithoutLine,fontName];
            [fontNamesArray addObject:fontNameWithoutLine];
        }
    }

    NSError * h_err = nil;
    NSError * m_err = nil;
    [h_string writeToFile:path_h atomically:YES encoding:NSUTF8StringEncoding error:&h_err];
    [m_string writeToFile:path_m atomically:YES encoding:NSUTF8StringEncoding error:&m_err];
    if (h_err) {
        NSLog(@"header 文件出错：%@",h_err.description);
    }
    if (m_err) {
        NSLog(@"implementation 文件出错：%@",m_err.description);
    }

    if (h_err == nil && m_err == nil) {
        NSLog(@"输出成功！");
    }
}



@end
