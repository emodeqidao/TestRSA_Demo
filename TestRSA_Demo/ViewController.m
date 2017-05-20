//
//  ViewController.m
//  TestRSA_Demo
//
//  Created by xixi_wen on 2017/5/20.
//  Copyright © 2017年 xixi_wen. All rights reserved.
//

#import "ViewController.h"
#import "RSAEncryptor.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //来自  http://www.jianshu.com/p/74a796ec5038#
    
    
    UIButton *btn = [self createBtn:@"加密-path" rect:CGRectMake(0, 30, 100, 35)];
    [btn addTarget:self action:@selector(encryptAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //http://web.chacuo.net/netrsakeypair 在线生成
    UIButton *btn2 = [self createBtn:@"加密-String" rect:CGRectMake(120, 30, 100, 35)];
    [btn2 addTarget:self action:@selector(decodeAction:) forControlEvents:UIControlEventTouchUpInside];
}

-(UIButton *)createBtn:(NSString *)titleStrArg rect:(CGRect)rectArg
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = rectArg;
    [btn setTitle:titleStrArg forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:btn];
    return btn;
}

//加密-path
-(void) encryptAction:(UIButton *)btnArg
{
    NSString *originalString = @"这是一段将要使用'.der'文件加密的字符串!";
    //使用.der和.p12中的公钥私钥加密解密
    NSString *public_key_path = [[NSBundle mainBundle] pathForResource:@"public_key.der" ofType:nil];
    NSString *private_key_path = [[NSBundle mainBundle] pathForResource:@"private_key.p12" ofType:nil];
    
    NSString *encryptStr = [RSAEncryptor encryptString:originalString publicKeyWithContentsOfFile:public_key_path];
    NSLog(@"加密前:%@", originalString);
    NSLog(@"加密后:%@", encryptStr);
    NSLog(@"解密后:%@", [RSAEncryptor decryptString:encryptStr privateKeyWithContentsOfFile:private_key_path password:@"lwjq123456"]);

}

//加密-String
-(void) decodeAction:(UIButton *)btnArg
{
     NSString *originalString = @"这是一段将要使用'秘钥字符串'进行加密的字符串!";
    NSString *pubKey = @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDc6onlB8nP7t40u6cEU3Lw8ebAxITC8SSSFfrd2fWEhmuenjxPwA6Zabj70AWMMacqDxqm/x/GuQrLA9LDFDd/ge1410b/hCe3vQqaO4b015YSx2bXftLW1IbP+qrA8PQeHC/FxVDHivUoU5XwGvaFuvTXzmIx57R5SWJk4EO7hwIDAQAB";
    //使用字符串格式的公钥私钥加密解密
    NSString *encryptStr = [RSAEncryptor encryptString:originalString publicKey:pubKey];
    NSLog(@"加密前:%@", originalString);
    NSLog(@"加密后:%@", encryptStr);
    NSString *priveKeyStr = @"MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBANzqieUHyc/u3jS7pwRTcvDx5sDEhMLxJJIV+t3Z9YSGa56ePE/ADplpuPvQBYwxpyoPGqb/H8a5CssD0sMUN3+B7XjXRv+EJ7e9Cpo7hvTXlhLHZtd+0tbUhs/6qsDw9B4cL8XFUMeK9ShTlfAa9oW69NfOYjHntHlJYmTgQ7uHAgMBAAECgYEArdvjRB0aBYvO0p9wNOZbyiYGXWULusO+7T1hHmHfaDnFzqJngrf6hV//1iWDiC63iVEzv4N/BY0xYk6S+zYY6ckF0jbQ58FeqTYEQXQq9IfIp9maKbVOhQUatdB/YdAUSM+grMo34mrYiPNEvoKpe6qWk74vl84R611IP2zy5eECQQDwtgC4QUebECx5O5k8xYhD+ln68+pslh+FLtn2d7m37HE2rs/Lvh9ik1AkSdqOdLtOlGsbSq5CwDAxyjD4thNXAkEA6vKrbNvN3hIvgI3STUU4XgltCQNOb9yVEGDqXHajiho/yQ0DM/l3d7VV8dnmqsJfn9dr91Zw4RPx+kR1+NgrUQJBALJ8Eg6OAR1+oauHQLnqMn9NXHkTcgjwTBECS4ZRAnnZrZ0BhH0rzbPXTb6KsK+e6OB8dur2tj4yqcnRhfx1beMCQQCaZqHrp0PShgb7p7gmGbBidDVYr/iTINZBbj92Rm1RK9DxUoDhXjd5zwzNJNMnMxfelpaYdBE4iYADZYxV3dIRAkB2oWcrPIzyWJlEz2ddHizSULpqddZqv+eRO4DKJgaBo+a3lU9Ux4baw8Ac+RhhijJXPVvwdKDuQ58XTmWOAOs0";
    NSString *afterStr = [RSAEncryptor decryptString:encryptStr privateKey:priveKeyStr];
    NSLog(@"解密后:%@", afterStr);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
