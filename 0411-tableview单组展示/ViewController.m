#import "ViewController.h"
#import "cellShow.h"
@interface ViewController () <UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>{
    NSMutableArray * _cellarr;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _cellarr = [NSMutableArray arrayWithObjects:
                [cellShow cellWithtitle:@"图书/音像" andSubtitle:@"开导,育人,启迪,节奏" andIcon:@"001.png"],
                [cellShow cellWithtitle:@"母婴孕品" andSubtitle:@"孕育,成长,呵护" andIcon:@"002.png"],
                [cellShow cellWithtitle:@"器械" andSubtitle:@"运动,健身" andIcon:@"003.png"],
                 nil];
    for (int i = 0; i < 100; i++) {
        NSString * title = [NSString stringWithFormat:@"产品-%d",i];
        NSString * subtitle = [NSString stringWithFormat:@"产品-%d好",i];
        NSString * iconname = [NSString stringWithFormat:@"00%d.png",i%9 + 1];
        
        [_cellarr addObject:[cellShow cellWithtitle:title andSubtitle:subtitle andIcon:iconname]];
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _cellarr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"cellForRowAtIndexPath---%ld",indexPath.row);
    static NSString * identifier = @"hehe";
    NSString * i1 = @"hehe";
    NSString * i2 = @"hehe";
    NSString * i3 = @"hehe";
    NSString * i4 = @"ckk";
    NSString * i5 = @"dkk";
    NSString * i6 = @"ekk";
    NSLog(@"identifier----%p",identifier);//好像用不用static都没事,identifier地址都一样.
    NSLog(@"i1----%p",i1);//字符串一样,i1,i2,i3,i4,i5,i6地址完全一样？
    NSLog(@"i2----%p",i2);//字符串不一样,其地址们都不一样
    NSLog(@"i3----%p",i3);
    NSLog(@"i4----%p",i4);
    NSLog(@"i5----%p",i5);
    NSLog(@"i6----%p",i6);
    
    UITableViewCell * cell = [_tableview dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        //alloc是在内存中,不是在缓存中.
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];

    }
#pragma mark 苹果把alloc产生不在view显示的cell放入了缓存,根据identifier取出cell,若没有匹配的identifier,再alloc一块内存给cell用

//    NSLog(@"cellForRowAtIndexPath---%p",cell);
    cellShow * cellshowcontent = _cellarr[indexPath.row];
    cell.textLabel.text = cellshowcontent.title;
    cell.detailTextLabel.text = cellshowcontent.subtitle;
    cell.imageView.image = [UIImage imageNamed:cellshowcontent.icon];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"didSelectRowAtIndexPath---%ld",indexPath.row);
    cellShow * cellshowcontent = _cellarr[indexPath.row];
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"产品信息展示" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert textFieldAtIndex:0].text = cellshowcontent.title;
    alert.tag = indexPath.row;
    [alert show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        return;
    }
    cellShow * cellshowcontent = _cellarr[alertView.tag];
    cellshowcontent.title = [alertView textFieldAtIndex:0].text;
    NSArray * indexpathsarr = @[[NSIndexPath indexPathForRow:[alertView tag] inSection:0]];
    [_tableview reloadRowsAtIndexPaths:indexpathsarr withRowAnimation:UITableViewRowAnimationLeft];
}

























- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
