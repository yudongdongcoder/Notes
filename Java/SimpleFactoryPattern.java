
public class SimpleFactoryPattern {
	public static void test() {
		   Chart chart;  
	        chart = ChartFactory.getChart("pie"); //通过静态工厂方法创建产品  
	        chart.display();  

	}

	static void testAbstract() {
		Product product;
		product = Factory.getProduct("A");// 通过工厂类创建产品对象
		product.methodSame();
		product.methodDiff();
	}
}

// abstract class
interface Chart {
	public void display();
}

// concrete class
class HistogramChart implements Chart {
	public HistogramChart() {
		System.out.println("创建柱状图");
	}

	public void display() {
		System.out.println("显示柱状图");
	}
}

class PieChart implements Chart {
	public PieChart() {
		System.out.println("创建饼状图");
	}

	public void display() {
		System.out.println("显示饼状图");
	}
}

class LineChart implements Chart {
	public LineChart() {
		System.out.println("创建折线图");
	}

	public void display() {
		System.out.println("显示折现图");
	}
}
// Factory 
class ChartFactory {
	public static Chart getChart(String type) {
		Chart chart = null;
		if (type.equalsIgnoreCase("histogram")) {
			chart = new HistogramChart();
			System.out.println("初始化设置柱状图");
		}
		else if (type.equalsIgnoreCase("pie")){
			chart = new PieChart();
			System.out.println("初始化设置饼状图");
		}
		else if (type.equalsIgnoreCase("line")){
			chart = new LineChart();
			System.out.println("初始化设置折线图");
		}
		return chart;
	}
}

// ● Factory（工厂角色）
class Factory {
	// 静态工厂方法
	public static Product getProduct(String arg) {
		Product product = null;
		if (arg.equalsIgnoreCase("A")) {
			product = new ConcreteProductA();
			// 初始化设置Product
		} else if (arg.equalsIgnoreCase("B")) {
			product = new ConcreteProductB();
			// 初始化设置product
		}
		return product;
	}
}

// ● Product（抽象产品角色）：
abstract class Product {
	// 所有产品类的公共业务方法
	public void methodSame() {
		// 公共方法的实现
	}

	// 声明抽象业务方法
	public abstract void methodDiff();
}

// ● ConcreteProduct（具体产品角色）
class ConcreteProductA extends Product {
	// 实现业务方法
	public void methodDiff() {
		// 业务方法的实现
	}
}

class ConcreteProductB extends Product {
	// 实现业务方法
	public void methodDiff() {
		// 业务方法的实现
	}
}