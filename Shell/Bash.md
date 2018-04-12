# bash
[TOC]

[Shell命令](http://www.runoob.com/linux/linux-command-manual.html
)

## `#!` 

是一个约定的标记，它告诉系统这个脚本需要什么解释器来执行，即使用哪一种 Shell

```bash
 #!/bin/bash

echo "Hello World !"
```
## Shell 变量

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
## Shell字符串
##### 单引号
```bash
str='this is a string'
```
单引号字符串的限制：

* 单引号里的任何字符都会原样输出，单引号字符串中的变量是无效的；
* 单引号字串中不能出现单引号（对单引号使用转义符后也不行）。

##### 双引号
```bash
your_name='qinjx'
str="Hello, I know your are \"$your_name\"! \n"
```
双引号的优点：
* 双引号里可以有变量
* 双引号里可以出现转义字符
##### 拼接字符串
```bash
your_name="qinjx"
greeting="hello, "$your_name" !"
greeting_1="hello, ${your_name} !"
echo $greeting $greeting_1
```
##### 获取字符串长度
```bash
string="abcd"
echo ${#string} #输出4
```
##### 提取子字符串
```bash
string="runoob is a great site"
echo ${string:1:4} #输出 unoo
```
##### 查找子字符串
```bash
string="runoob is a great company"
echo `expr index "$string" is` #输出8，要在linux下运行，mac下会报错
```
## Shell 数组
bash支持一维数组（不支持多维数组）
##### 定义数组
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
##### 读取数组
```bash
value=${array_name[n]}
#使用@符号可以获取数组中的所有元素，例如：
echo ${array_name[@]}
echo ${array_name[*]}
```
##### 获取数组的长度
```bash
# 取得数组元素的个数
length=${#array_name[@]}
# 或者
length=${#array_name[*]}
# 取得数组单个元素的长度
lengthn=${#array_name[n]}
```

##Shell 传递参数
##### 实例
```bash
#!/bin/bash

echo "Shell 传递参数实例！";
echo "执行的文件名：$0";#其中 $0 为执行的文件名
echo "第一个参数为：$1";
echo "第二个参数为：$2";
echo "第三个参数为：$3";
```

还有几个特殊字符用来处理参数

|    参数处理  |说明      |
| :--- | :--- |
|  $#    |  传递到脚本的参数个数    |
|  $*    | 以一个单字符串显示所有向脚本传递的参数。如"$*"用「"」括起来的情况、以"$1 $2 … $n"的形式输出所有参数。 |
| $$ | 脚本运行的当前进程ID号 |
| $! | 后台运行的最后一个进程的ID号 |
| $@ | 与$*相同，但是使用时加引号，并在引号中返回每个参数。如"$@"用「"」括起来的情况、以"$1" "$2" … "$n" 的形式输出所有参数。 |
| $- | 显示Shell使用的当前选项 |
|$?|显示最后命令的退出状态。0表示没有错误，其他任何值表明有错误|

## Shell 基本运算符
##### 算术运算符

两点注意：

* 表达式和运算符之间要有空格，例如 2+2 是不对的，必须写成 2 + 2，这与我们熟悉的大多数编程语言不一样。
* 完整的表达式要被\` \` 包含，注意这个字符不是常用的单引号，在 Esc 键下边。

表列出了常用的算术运算符，假定变量 a 为 10，变量 b 为 20：

|运算符|说明|	举例|
| :--- | :--- | :--- |
|+|	加法|	\`expr $a + $b\` 结果为 30。|
|-|减法|	\`expr $a - $b\` 结果为 -10。|
|*|乘法| \`expr $a  \* $b\` 结果为  200。 |
|/|除法| \`expr $b / $a\` 结果为 2。 |
|%|取余| \`expr $b \% $a\` 结果为 0。 |
|=|赋值|	a=$b 将把变量 b 的值赋给 a。|
|==|相等。|用于比较两个数字，相同则返回 true。	[ $a == $b ] 返回 false。|
|!=|不相等。|用于比较两个数字，不相同则返回 true。	[ $a != $b ] 返回 true。|

**主意：**条件表达式要放在方括号之间，并且要有空格，例如: **[\$a==\$b]** 是错误的，必须写成 **[  \$a == \$b  ]**。



**注意：**

- 乘号(*)前边必须加反斜杠(\\)才能实现乘法运算；
- 在 MAC 中 shell 的 expr 语法是：**$((表达式))**，此处表达式中的 "*" 不需要转义符号 "\" 。

```bash
#!/bin/bash

a=10
b=20

val=`expr $a + $b`
echo "a + b : $val"

val=`expr $a - $b`
echo "a - b : $val"

val=`expr $a \* $b`
echo "a * b : $val"

val=`expr $b / $a`
echo "b / a : $val"

val=`expr $b % $a`
echo "b % a : $val"

if [ $a == $b ]
then
   echo "a 等于 b"
fi
if [ $a != $b ]
then
   echo "a 不等于 b"
fi
```



##### 关系运算符

关系运算符只支持数字，不支持字符串，除非字符串的值是数字。

下表列出了常用的关系运算符，假定变量 a 为 10，变量 b 为 20：

| 运算符 | 说明                                                  | 举例                         |
| ------ | ----------------------------------------------------- | ---------------------------- |
| -eq    | 检测两个数是否相等，相等返回 true。                   | [ \$a -eq \$b ] 返回 false。 |
| -ne    | 检测两个数是否相等，不相等返回 true。                 | [ \$a -ne \$b ] 返回 true。  |
| -gt    | 检测左边的数是否大于右边的，如果是，则返回 true。     | [ \$a -gt \$b ] 返回 false。 |
| -lt    | 检测左边的数是否小于右边的，如果是，则返回 true。     | [ \$a -lt \$b ] 返回 true。  |
| -ge    | 检测左边的数是否大于等于右边的，如果是，则返回 true。 | [ \$a -ge \$b ] 返回 false。 |
| -le    | 检测左边的数是否小于等于右边的，如果是，则返回 true。 | [ \$a -le \$b ] 返回 true。  |

```bash
#!/bin/bash
a=10
b=20

if [ $a -eq $b ]
then
   echo "$a -eq $b : a 等于 b"
else
   echo "$a -eq $b: a 不等于 b"
fi
if [ $a -ne $b ]
then
   echo "$a -ne $b: a 不等于 b"
else
   echo "$a -ne $b : a 等于 b"
fi
if [ $a -gt $b ]
then
   echo "$a -gt $b: a 大于 b"
else
   echo "$a -gt $b: a 不大于 b"
fi
if [ $a -lt $b ]
then
   echo "$a -lt $b: a 小于 b"
else
   echo "$a -lt $b: a 不小于 b"
fi
if [ $a -ge $b ]
then
   echo "$a -ge $b: a 大于或等于 b"
else
   echo "$a -ge $b: a 小于 b"
fi
if [ $a -le $b ]
then
   echo "$a -le $b: a 小于或等于 b"
else
   echo "$a -le $b: a 大于 b"
fi
```

##### 布尔运算符

下表列出了常用的布尔运算符，假定变量 a 为 10，变量 b 为 20：

| 运算符 | 说明                                                | 举例                                       |
| ------ | --------------------------------------------------- | ------------------------------------------ |
| !      | 非运算，表达式为 true 则返回 false，否则返回 true。 | [ ! false ] 返回 true。                    |
| -o     | 或运算，有一个表达式为 true 则返回 true。           | [ \$a -lt 20 -o\$b -gt 100 ] 返回 true。   |
| -a     | 与运算，两个表达式都为 true 才返回 true。           | [ \$a -lt 20 -a \$b -gt 100 ] 返回 false。 |

###### 实例

布尔运算符实例如下：

```bash
#!/bin/bash

a=10
b=20

if [ $a != $b ]
then
   echo "$a != $b : a 不等于 b"
else
   echo "$a != $b: a 等于 b"
fi
if [ $a -lt 100 -a $b -gt 15 ]
then
   echo "$a 小于 100 且 $b 大于 15 : 返回 true"
else
   echo "$a 小于 100 且 $b 大于 15 : 返回 false"
fi
if [ $a -lt 100 -o $b -gt 100 ]
then
   echo "$a 小于 100 或 $b 大于 100 : 返回 true"
else
   echo "$a 小于 100 或 $b 大于 100 : 返回 false"
fi
if [ $a -lt 5 -o $b -gt 100 ]
then
   echo "$a 小于 5 或 $b 大于 100 : 返回 true"
else
   echo "$a 小于 5 或 $b 大于 100 : 返回 false"
fi
```
##### 逻辑运算符

以下介绍 Shell 的逻辑运算符，假定变量 a 为 10，变量 b 为 20:

| 运算符 | 说明       | 举例                                         |
| ------ | ---------- | -------------------------------------------- |
| &&     | 逻辑的 AND | [[ \$a -lt 100 && \$b -gt 100 ]] 返回 false  |
| \|\|   | 逻辑的 OR  | [[ \$a -lt 100 \|\| \$b -gt 100 ]] 返回 true |

###### 实例

逻辑运算符实例如下：

```bash
#!/bin/bash

a=10
b=20

if [[ $a -lt 100 && $b -gt 100 ]]
then
   echo "返回 true"
else
   echo "返回 false"
fi

if [[ $a -lt 100 || $b -gt 100 ]]
then
   echo "返回 true"
else
   echo "返回 false"
fi
```


##### 字符串运算符

下表列出了常用的字符串运算符，假定变量 a 为 "abc"，变量 b 为 "efg"：

| 运算符 | 说明                                      | 举例                       |
| ------ | ----------------------------------------- | -------------------------- |
| =      | 检测两个字符串是否相等，相等返回 true。   | [ \$a = \$b ] 返回 false。 |
| !=     | 检测两个字符串是否相等，不相等返回 true。 | [ \$a != \$b ] 返回 true。 |
| -z     | 检测字符串长度是否为0，为0返回 true。     | [ -z \$a ] 返回 false。    |
| -n     | 检测字符串长度是否为0，不为0返回 true。   | [ -n $a ] 返回 true。      |
| str    | 检测字符串是否为空，不为空返回 true。     | [ $a ] 返回 true。         |

###### 实例

字符串运算符实例如下：

```bash
#!/bin/bash

a="abc"
b="efg"

if [ $a = $b ]
then
   echo "$a = $b : a 等于 b"
else
   echo "$a = $b: a 不等于 b"
fi
if [ $a != $b ]
then
   echo "$a != $b : a 不等于 b"
else
   echo "$a != $b: a 等于 b"
fi
if [ -z $a ]
then
   echo "-z $a : 字符串长度为 0"
else
   echo "-z $a : 字符串长度不为 0"
fi
if [ -n $a ]
then
   echo "-n $a : 字符串长度不为 0"
else
   echo "-n $a : 字符串长度为 0"
fi
if [ $a ]
then
   echo "$a : 字符串不为空"
else
   echo "$a : 字符串为空"
fi
```
##### 文件测试运算符

文件测试运算符用于检测 Unix 文件的各种属性。

属性检测描述如下：

| 操作符  | 说明                                                         | 举例                      |
| ------- | ------------------------------------------------------------ | ------------------------- |
| -b file | 检测文件是否是块设备文件，如果是，则返回 true。              | [ -b $file ] 返回 false。 |
| -c file | 检测文件是否是字符设备文件，如果是，则返回 true。            | [ -c $file ] 返回 false。 |
| -d file | 检测文件是否是目录，如果是，则返回 true。                    | [ -d $file ] 返回 false。 |
| -f file | 检测文件是否是普通文件（既不是目录，也不是设备文件），如果是，则返回 true。 | [ -f $file ] 返回 true。  |
| -g file | 检测文件是否设置了 SGID 位，如果是，则返回 true。            | [ -g $file ] 返回 false。 |
| -k file | 检测文件是否设置了粘着位(Sticky Bit)，如果是，则返回 true。  | [ -k $file ] 返回 false。 |
| -p file | 检测文件是否是有名管道，如果是，则返回 true。                | [ -p $file ] 返回 false。 |
| -u file | 检测文件是否设置了 SUID 位，如果是，则返回 true。            | [ -u $file ] 返回 false。 |
| -r file | 检测文件是否可读，如果是，则返回 true。                      | [ -r $file ] 返回 true。  |
| -w file | 检测文件是否可写，如果是，则返回 true。                      | [ -w $file ] 返回 true。  |
| -x file | 检测文件是否可执行，如果是，则返回 true。                    | [ -x $file ] 返回 true。  |
| -s file | 检测文件是否为空（文件大小是否大于0），不为空返回 true。     | [ -s $file ] 返回 true。  |
| -e file | 检测文件（包括目录）是否存在，如果是，则返回 true。          | [ -e $file ] 返回 true。  |

###### 实例

变量 file 表示文件"/var/www/runoob/test.sh"，它的大小为100字节，具有 rwx 权限。下面的代码，将检测该文件的各种属性：

```bash
#!/bin/bash

file="/var/www/runoob/test.sh"
if [ -r $file ]
then
   echo "文件可读"
else
   echo "文件不可读"
fi
if [ -w $file ]
then
   echo "文件可写"
else
   echo "文件不可写"
fi
if [ -x $file ]
then
   echo "文件可执行"
else
   echo "文件不可执行"
fi
if [ -f $file ]
then
   echo "文件为普通文件"
else
   echo "文件为特殊文件"
fi
if [ -d $file ]
then
   echo "文件是个目录"
else
   echo "文件不是个目录"
fi
if [ -s $file ]
then
   echo "文件不为空"
else
   echo "文件为空"
fi
if [ -e $file ]
then
   echo "文件存在"
else
   echo "文件不存在"
fi
```
## Shell echo命令

```bash
	echo "It is a test" #It is a test
	echo "\"It is a test\"" #显示转义字符 结果将是:"It is a test"
	read name 
	echo "$name It is a test" #显示变量 read 命令从标准输入中读取一行,并把输入行的每个字段的值指定给 shell 变量
	echo -e "OK! \n" # 显示换行 -e 开启转义
	echo "It it a test"
	echo -e "OK! \c" # 显示不换行 -e 开启转义 \c 不换行
	echo "It is a test"
	echo "It is a test" > myfile #显示结果定向至文件
	echo '$name\"' #原样输出字符串，不进行转义或取变量(用单引号)
	echo `date` #显示命令执行结果 结果将显示当前日期
```
## Shell printf 命令

```bash
printf  format-string  [arguments...]
```

**参数说明：**

- **format-string:** 为格式控制字符串

- **arguments:** 为参数列表。

  ```bash
  printf "%-10s %-8s %-4s\n" 姓名 性别 体重kg  
  printf "%-10s %-8s %-4.2f\n" 郭靖 男 66.1234 
  printf "%-10s %-8s %-4.2f\n" 杨过 男 48.6543 
  printf "%-10s %-8s %-4.2f\n" 郭芙 女 47.9876 
  #%s %c %d %f都是格式替代符
  #%-10s 指一个宽度为10个字符（-表示左对齐，没有则表示右对齐），任何字符都会被显示在10个字符宽的字符内，如果不足则自动以空格填充，超过也会将内容全部显示出来。
  #%-4.2f 指格式化为小数，其中.2指保留2位小数

  # format-string为双引号
  printf "%d %s\n" 1 "abc"

  # 单引号与双引号效果一样 
  printf '%d %s\n' 1 "abc" 

  # 没有引号也可以输出
  printf %s abcdef

  # 格式只指定了一个参数，但多出的参数仍然会按照该格式输出，format-string 被重用
  printf %s abc def

  printf "%s\n" abc def

  printf "%s %s %s\n" a b c d e f g h i j

  # 如果没有 arguments，那么 %s 用NULL代替，%d 用 0 代替
  printf "%s and %d \n" 
  ```

  ## printf的转义序列

  | 序列  | 说明                                                         |
  | ----- | ------------------------------------------------------------ |
  | \a    | 警告字符，通常为ASCII的BEL字符                               |
  | \b    | 后退                                                         |
  | \c    | 抑制（不显示）输出结果中任何结尾的换行字符（只在%b格式指示符控制下的参数字符串中有效），而且，任何留在参数里的字符、任何接下来的参数以及任何留在格式字符串中的字符，都被忽略 |
  | \f    | 换页（formfeed）                                             |
  | \n    | 换行                                                         |
  | \r    | 回车（Carriage return）                                      |
  | \t    | 水平制表符                                                   |
  | \v    | 垂直制表符                                                   |
  | \\    | 一个字面上的反斜杠字符                                       |
  | \ddd  | 表示1到3位数八进制值的字符。仅在格式字符串中有效             |
  | \0ddd | 表示1到3位的八进制值字符                                     |

## Shell test 命令

##### 数值测试

| 参数 | 说明           |
| ---- | -------------- |
| -eq  | 等于则为真     |
| -ne  | 不等于则为真   |
| -gt  | 大于则为真     |
| -ge  | 大于等于则为真 |
| -lt  | 小于则为真     |
| -le  | 小于等于则为真 |

实例演示：

```bash
num1=100
num2=100
if test $[num1] -eq $[num2]
then
    echo '两个数相等！'
else
    echo '两个数不相等！'
fi          #代码中的 [] 执行基本的算数运算，如：

a=5
b=6

result=$[a+b] # 注意等号两边不能有空格
echo "result 为： $result"
```
##### 字符串测试

| 参数      | 说明                     |
| --------- | ------------------------ |
| =         | 等于则为真               |
| !=        | 不相等则为真             |
| -z 字符串 | 字符串的长度为零则为真   |
| -n 字符串 | 字符串的长度不为零则为真 |

```bash
num1="ru1noob"
num2="runoob"
if test $num1 = $num2
then
    echo '两个字符串相等!'
else
    echo '两个字符串不相等!'
fi
```

###### 文件测试

| 参数      | 说明                                 |
| --------- | ------------------------------------ |
| -e 文件名 | 如果文件存在则为真                   |
| -r 文件名 | 如果文件存在且可读则为真             |
| -w 文件名 | 如果文件存在且可写则为真             |
| -x 文件名 | 如果文件存在且可执行则为真           |
| -s 文件名 | 如果文件存在且至少有一个字符则为真   |
| -d 文件名 | 如果文件存在且为目录则为真           |
| -f 文件名 | 如果文件存在且为普通文件则为真       |
| -c 文件名 | 如果文件存在且为字符型特殊文件则为真 |
| -b 文件名 | 如果文件存在且为块特殊文件则为真     |

```bash
cd /bin
if test -e ./bash
then
    echo '文件已存在!'
else
    echo '文件不存在!'
fi
```

## Shell 流程控制

if 语句语法格式：

```bash
# if
if condition
then
    command1 
    command2
    ...
    commandN 
fi

#if else 语法格式
if condition
then
    command1 
    command2
    ...
    commandN
else
    command
fi

#if else-if else 语法格式
if condition1
then
    command1
elif condition2 
then 
    command2
else
    commandN
fi

```

##### for 循环

```bash
for var in item1 item2 ... itemN
do
    command1
    command2
    ...
    commandN
done

for var in item1 item2 ... itemN; do command1; command2… done;#写成一行
```

##### while 语句

```bash
while condition
do
    command
done
```

##### 无限循环

无限循环语法格式：

```
while :
do
    command
done
```

或者

```
while true
do
    command
done
```

或者

```
for (( ; ; ))
```
##### until 循环

until循环执行一系列命令直至条件为真时停止。

until 语法格式:

```
until condition
do
    command
done
```

条件可为任意测试条件，测试发生在循环末尾，因此循环至少执行一次—请注意这一点

##### case

```bash
echo '输入 1 到 4 之间的数字:'
echo '你输入的数字为:'
read aNum
case $aNum in
    1)  echo '你选择了 1'
    ;;
    2)  echo '你选择了 2'
    ;;
    3)  echo '你选择了 3'
    ;;
    4)  echo '你选择了 4'
    ;;
    *)  echo '你没有输入 1 到 4 之间的数字'
    ;;
esac
```

##### 跳出循环

###### break命令

break命令允许跳出所有循环（终止执行后面的所有循环）。


```bash
#!/bin/bash
while :
do
    echo -n "输入 1 到 5 之间的数字:"
    read aNum
    case $aNum in
        1|2|3|4|5) echo "你输入的数字为 $aNum!"
        ;;
        *) echo "你输入的数字不是 1 到 5 之间的! 游戏结束"
            break
        ;;
    esac
done
```

###### continue

continue命令与break命令类似，只有一点差别，它不会跳出所有循环，仅仅跳出当前循环。

```bash
#!/bin/bash
while :
do
    echo -n "输入 1 到 5 之间的数字: "
    read aNum
    case $aNum in
        1|2|3|4|5) echo "你输入的数字为 $aNum!"
        ;;
        *) echo "你输入的数字不是 1 到 5 之间的!"
            continue
            echo "游戏结束"
        ;;
    esac
done
```

运行代码发现，当输入大于5的数字时，该例中的循环不会结束，语句 **echo "游戏结束"** 永远不会被执行。

## Shell 函数

```bash
demoFun(){
    echo "这是我的第一个 shell 函数!"
}
echo "-----函数开始执行-----"
demoFun
echo "-----函数执行完毕-----"

funWithReturn(){
    echo "这个函数会对输入的两个数字进行相加运算..."
    echo "输入第一个数字: "
    read aNum
    echo "输入第二个数字: "
    read anotherNum
    echo "两个数字分别为 $aNum 和 $anotherNum !"
    return $(($aNum+$anotherNum))
}
funWithReturn
echo "输入的两个数字之和为 $? !"
#函数返回值在调用该函数后通过 $? 来获得。
funWithParam(){
    echo "第一个参数为 $1 !"
    echo "第二个参数为 $2 !"
    echo "第十个参数为 $10 !"
    echo "第十个参数为 ${10} !"
    echo "第十一个参数为 ${11} !"
    echo "参数总数有 $# 个!"
    echo "作为一个字符串输出所有参数 $* !"
}
funWithParam 1 2 3 4 5 6 7 8 9 34 73
#$10 不能获取第十个参数，获取第十个参数需要${10}。当n>=10时，需要使用${n}来获取参数
```

另外，还有几个特殊字符用来处理参数：

| 参数处理 | 说明                                                         |
| -------- | ------------------------------------------------------------ |
| $#       | 传递到脚本的参数个数                                         |
| $*       | 以一个单字符串显示所有向脚本传递的参数                       |
| $$       | 脚本运行的当前进程ID号                                       |
| $!       | 后台运行的最后一个进程的ID号                                 |
| $@       | 与$*相同，但是使用时加引号，并在引号中返回每个参数。         |
| $-       | 显示Shell使用的当前选项，与set命令功能相同。                 |
| $?       | 显示最后命令的退出状态。0表示没有错误，其他任何值表明有错误。 |

## Shell 输入/输出重定向

| 命令            | 说明                                               |
| --------------- | -------------------------------------------------- |
| command > file  | 将输出重定向到 file。                              |
| command < file  | 将输入重定向到 file。                              |
| command >> file | 将输出以追加的方式重定向到 file。                  |
| n > file        | 将文件描述符为 n 的文件重定向到 file。             |
| n >> file       | 将文件描述符为 n 的文件以追加的方式重定向到 file。 |
| n >& m          | 将输出文件 m 和 n 合并。                           |
| n <& m          | 将输入文件 m 和 n 合并。                           |
| << tag          | 将开始标记 tag 和结束标记 tag 之间的内容作为输入。 |

## Shell 文件包含

```bash
. filename   # 注意点号(.)和文件名中间有一空格

或

source filename
```

