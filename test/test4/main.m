//
//  main.m
//  test4
//
//  Created by 龚嘉骏 on 2024/6/19.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
@property (copy) NSString *name;
@property (assign) int age;

-(void)introduce;
@end

int main(int argc, const char * argv[]) {
    Person *gg = [[Person alloc] init];
    gg.name = @"张三";
    gg.age = 20;
    
    Person *mm = [[Person alloc] init];
    mm.name = @"里斯本";
    mm.age = 28;
    
    [gg introduce];
    [mm introduce];
    return 0;
}

@implementation Person
-(void)introduce{
    NSLog(@"Hello, my name is %@ and I am %d years old.", self.name, self.age);
}
@end
