# 抽象工厂
**抽象工厂**：提供一个创建一系列相关或相互依赖对象的接口，而无需指定他们具体的类。
## 适用性
- 一个系统要独立于他的产品的创建、组合和表示时
- 一个系统要由多个产品系列中的一个来配置时
- 当你要强调一系列相关的产品对象的设计以便进行联合使用时
- 当你提供一个产品类库，而只想显示它们的接口而不是实现时

## 结构
![Abstract Factory](./resources/Abstract Factory UML.png)
- **AbstractFactory**:声明一个创建抽象产品对象的操作接口
- **ConcreteFactory**：实现创建具体产品对象的操作
- **AbstractProduct**：为一类产品对象声明一个接口
- **ConcreteProduct**：定义一个将被相应的具体工厂创建的产品对象；实现AbstractProduct接口
- **Client**：仅使用由AbstractFactory和AbstractProduct类声明的接口
## 效果
**缺点**：难以支持新种类的产品

**优点：**

1. 它分离了具体的类
2. 它使得易于交换产品系列
3. 它有利于产品的一致性

## 总结

**工厂方法和抽象工厂的区别**

|      抽象工厂| 工厂方法 |
| :--: | :--: |
| 通过对象组合创建抽象产品 | 通过类继承创建抽象产品 |
| 创建多系列产品 | 创建一种产品 |
| 必须修改父类的接口才能支持新的产品 | 子类化创建者并重载工厂方法以创建新产品 |
