# bash
[TOC]

### `#!` 

是一个约定的标记，它告诉系统这个脚本需要什么解释器来执行，即使用哪一种 Shell

```bash
 #!/bin/bash

echo "Hello World !"
```
### Shell 变量

##### 定义变量时，变量名不加美元符号

```bash
your_name="runoob.com"
```
##### 使用变量(变量名外面的花括号是可选的，加不加都行)
```bash
your_name="qinjx"
echo $your_name
echo ${your_name}
```
##### 只读变量
使用 readonly 命令可以将变量定义为只读变量，只读变量的值不能被改变。
```bash
#!/bin/bash
myUrl="http://www.w3cschool.cc"
readonly myUrl
myUrl="http://www.runoob.com"
```
##### 删除变量
使用 unset 命令可以删除变量,变量被删除后不能再次使用。unset 命令不能删除只读变量
```bash
#!/bin/sh
myUrl="http://www.runoob.com"
unset myUrl
echo $myUrl
```
##### 变量类型
1. **局部变量**局部变量在脚本或命令中定义，仅在当前shell实例中有效，其他shell启动的程序不能访问局部变量。

2. **环境变量** 所有的程序，包括shell启动的程序，都能访问环境变量，有些程序需要环境变量来保证其正常运行。必要的时候shell脚本也可以定义环境变量。
3. **shell变量** shell变量是由shell程序设置的特殊变量。shell变量中有一部分是环境变量，有一部分是局部变量，这些变量保证了shell的正常运行
### Shell字符串
###### 单引号
```bash
str='this is a string'
```
单引号字符串的限制：

* 单引号里的任何字符都会原样输出，单引号字符串中的变量是无效的；
* 单引号字串中不能出现单引号（对单引号使用转义符后也不行）。

###### 双引号
```bash
your_name='qinjx'
str="Hello, I know your are \"$your_name\"! \n"
```
双引号的优点：
* 双引号里可以有变量
* 双引号里可以出现转义字符
###### 拼接字符串
```bash
your_name="qinjx"
greeting="hello, "$your_name" !"
greeting_1="hello, ${your_name} !"
echo $greeting $greeting_1
```
###### 获取字符串长度
```bash
string="abcd"
echo ${#string} #输出4
```
###### 提取子字符串
```bash
string="runoob is a great site"
echo ${string:1:4} #输出 unoo
```
###### 查找子字符串
```bash
string="runoob is a great company"
echo `expr index "$string" is` #输出8，要在linux下运行，mac下会报错
```
### Shell 数组
bash支持一维数组（不支持多维数组）
###### 定义数组
```bash
array_name=(value0 value1 value2 value3)

array_name=(
value0
value1
value2
value3
)

array_name[0]=value0
array_name[1]=value1
array_name[n]=valuen
```
###### 读取数组
```bash
value=${array_name[n]}
#使用@符号可以获取数组中的所有元素，例如：
echo ${array_name[@]}
```
###### 获取数组的长度
```bash
# 取得数组元素的个数
length=${#array_name[@]}
# 或者
length=${#array_name[*]}
# 取得数组单个元素的长度
lengthn=${#array_name[n]}
```









