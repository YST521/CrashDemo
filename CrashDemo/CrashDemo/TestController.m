//
//  TestController.m
//  CrashDemo
//
//  Created by youxin on 2018/12/28.
//  Copyright © 2018年 yst. All rights reserved.
//

#import "TestController.h"

@interface TestController ()

@end

@implementation TestController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UILabel *la = [[UILabel alloc]init];
    la.frame = CGRectMake(0, 100, self.view.frame.size.width, 100);
    [self.view addSubview:la];
    
    //实际提现 富文本
    NSString *account = @"100.0000";
    NSString *noAccount = @"66:00";
    NSString *accountNum = @"9000:00";
    //第一段
    NSDictionary *dic1 = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    
    NSMutableAttributedString *att1 = [[NSMutableAttributedString alloc]initWithString:accountNum attributes:dic1];
    [att1 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0,accountNum.length)];
    
    NSString *str2 = @"  (到账 ";
    NSDictionary *dic2 = @{NSFontAttributeName: [UIFont systemFontOfSize:10]};
    NSMutableAttributedString *att2  = [[NSMutableAttributedString alloc]initWithString:str2 attributes:dic2];
    [att2 addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0,str2.length)];
    
    NSMutableAttributedString *att3 = [[NSMutableAttributedString alloc]initWithString:account];
    [att3 addAttribute:NSFontAttributeName value: [UIFont systemFontOfSize:10] range:NSMakeRange(0,account.length)];
    [att3 addAttribute:NSForegroundColorAttributeName value: [UIColor greenColor] range:NSMakeRange(0,account.length)];
    
    
    NSString *str4 = [NSString stringWithFormat:@"   未到账：%@ ）",noAccount];
    NSDictionary *dic4 = @{NSFontAttributeName: [UIFont systemFontOfSize:10]};
    NSMutableAttributedString *att4  = [[NSMutableAttributedString alloc]initWithString:str4 attributes:dic4];
    [att4 addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0,str4.length)];
    
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithAttributedString: att1];
    [attributedStr appendAttributedString:att2];
    [attributedStr appendAttributedString: att3];
    [attributedStr appendAttributedString: att4];
    
    la.attributedText = attributedStr;
   
    
}



/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
