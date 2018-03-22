# bash

##`#!` 

是一个约定的标记，它告诉系统这个脚本需要什么解释器来执行，即使用哪一种 Shell

```bash
 #!/bin/bash

echo "Hello World !"
```
##Shell 变量

####定义变量时，变量名不加美元符号

```bash
your_name="runoob.com"
```
###使用变量(变量名外面的花括号是可选的，加不加都行)
```bash
your_name="qinjx"
echo $your_name
echo ${your_name}
```
###只读变量
使用 readonly 命令可以将变量定义为只读变量，只读变量的值不能被改变。
```bash
#!/bin/bash
myUrl="http://www.w3cschool.cc"
readonly myUrl
myUrl="http://www.runoob.com"
```
###删除变量
使用 unset 命令可以删除变量,变量被删除后不能再次使用。unset 命令不能删除只读变量
```bash
#!/bin/sh
myUrl="http://www.runoob.com"
unset myUrl
echo $myUrl
```
###变量类型
1.**局部变量**局部变量在脚本或命令中定义，仅在当前shell实例中有效，其他shell启动的程序不能访问局部变量。
2.**环境变量** 所有的程序，包括shell启动的程序，都能访问环境变量，有些程序需要环境变量来保证其正常运行。必要的时候shell脚本也可以定义环境变量。
3.**shell变量** shell变量是由shell程序设置的特殊变量。shell变量中有一部分是环境变量，有一部分是局部变量，这些变量保证了shell的正常运行