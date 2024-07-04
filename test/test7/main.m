//
//  main.m
//  test7
//
//  Created by 龚嘉骏 on 2024/6/19.
//

#import <Foundation/Foundation.h>

void readFromFile(NSString *filePath){
    NSLog(@"开始读取文件。");
    NSError *error = nil;
    NSString *fileContent = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    if (fileContent) {
        NSLog(@"%@", fileContent);
    }else{
        NSLog(@"读取文件 %@ 失败，错误信息: %@", filePath, [error localizedDescription]);
    }
}


int main(int argc, const char * argv[]) {

    NSString *currentDirectory = [[NSFileManager defaultManager] currentDirectoryPath];
    NSString *filePath = [currentDirectory stringByAppendingPathComponent:@"data.txt"];
    //NSString *filePath = @"./data.txt";
    
    NSString *text = @"你好。\n";
    NSError *error = nil;
    BOOL flag = [text writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
    if (flag) {
        NSLog(@"%@ 文件写入成功。", filePath);
    }else{
        NSLog(@"写入文件 %@ 失败，错误信息: %@", filePath, [error localizedDescription]);
    }
    
    readFromFile(filePath);
    
    text = @"再见";
    //NSLog(@"%@", text);
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:filePath];
    if (fileHandle == nil) {
        NSLog(@"打开文件 %@ 失败", filePath);
    }
    [fileHandle seekToEndOfFile];
    [fileHandle writeData:[text dataUsingEncoding:NSUTF8StringEncoding]];
    [fileHandle closeFile];
    
    readFromFile(filePath);
    
    return 0;
}
