//: Playground - noun: a place where people can play

import UIKit

// 与OC 和 C 不同，Swift的赋值符号自身不会有返回值
var (x, y) = (1, 2)
//if x = y { //这样做是不合法的
//    
//}

//: 算数运算符 + - * / 不允许值溢出 加法运算符支持字符串拼接
let hello = "hello," + "world"

//: ==、!=、>、<、 >=、 <= 都是类似的
//: swift 也提供两个等价运算符（=== 和 ！==），使用它们来判断两个对象的引用是否相同

//: 合并空值运算符
//: 合并空值运算符（a ?? b）如果可选项 a 有值则展开，如果没有值，是nil，则返回默认值b。表达式a必须是一个可选类型。表达式b必须与a的存储类型相同
var userDefineColorName:String?
var colorName = userDefineColorName ?? "red"

//: 区间运算符
//: 闭区间运算符 a...b 定义了从a到b的一组范围，并且包含a和b。a的值不能大于b。
for index in 1...5 {
    print("\(index) times 5 is \(index * 5)")
}
//: 半开区间运算符
//: 半开区间运算符（a..<b）定义了从a 到 b但不包括b的区间，即半开

