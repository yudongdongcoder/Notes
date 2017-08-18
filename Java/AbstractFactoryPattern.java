
public class AbstractFactoryPattern {

static void test() {
		SkinFactory factory;
		Button bt;
		TextField tf;
		ComboBox cb;
		factory = new SpringSkinFactory();
		bt = factory.createButton();
		tf = factory.createTextField();
		cb = factory.createComboBox();
		bt.display();
		tf.display();
		cb.display();
	}

}

// abstract product
interface Button {
	public void display();
}

interface TextField {
	public void display();
}

interface ComboBox {
	public void display();
}

// concrete product
class SpringButton implements Button {
	public void display() {
		System.out.println("显示浅绿色按钮");
	}
}

class SummerButton implements Button {
	public void display() {
		System.out.println("显示蓝色按钮");
	}
}

class SpringTextField implements TextField {
	public void display() {
		System.out.println("显示绿色边框文本框。");
	}
}

class SummerTextField implements TextField {
	public void display() {
		System.out.println("显示蓝色边框文本框。");
	}
}

class SpringComboBox implements ComboBox {
	public void display() {
		System.out.println("显示绿色边框组合框。");
	}
}

class SummerComboBox implements ComboBox {
	public void display() {
		System.out.println("显示蓝色边框组合框。");
	}
}

// abstract factory
interface SkinFactory {
	public Button createButton();
	public TextField createTextField();
	public ComboBox createComboBox();
}

//concrete Factory
class SpringSkinFactory implements SkinFactory {
	public Button createButton() {
		return new SpringButton();
	}
	public TextField createTextField() {
		return new SpringTextField();
	}
	public ComboBox createComboBox() {
		return new SpringComboBox();
	}
}
class SummerSkinFactory implements SkinFactory {  
    public Button createButton() {  
        return new SummerButton();  
    }  
  
    public TextField createTextField() {  
        return new SummerTextField();  
    }  
  
    public ComboBox createComboBox() {  
        return new SummerComboBox();  
    }  
}  
