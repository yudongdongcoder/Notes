//
//  main.m
//  Algorithm
//
//  Created by QD on 2017/6/3.
//  Copyright © 2017年 QDDemo. All rights reserved.
//

#import <Foundation/Foundation.h>

// 时间复杂度O(h)=O(log2n)
int binarySearch(NSArray *array,int item){
    int low = 0;
    int high = (int)array.count - 1;
    while (low <= high) {
        int mid = (high + low)/2;
        if (item == [array[mid] intValue]) {
            return mid;
        }else if(item < [array[mid] intValue]){
            high = mid - 1;
        }else{
            low = mid + 1;
        }
    }
    return -1;
}


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSArray *array = @[@1,@3,@5,@7,@9,@11,@13,@15,@17,@19,@21,@23,@25];
    
        int result = binarySearch(array,7);
        NSLog(@"%d",result);
    }
    return 0;
}


