
public class BridgePattern {
	static void test() {
		 Image image;  
	        ImageImp imp;  
	        image =  new PNGImage();
	        imp =  new LinuxImp();
	        image.setImageImp(imp);  
	        image.parseFile("小龙女");  
	}
}

class Matrix {

}

abstract class Image {
	protected ImageImp imp;

	public void setImageImp(ImageImp imp) {
		this.imp = imp;
	}

    public abstract void parseFile(String fileName);  

}

interface ImageImp {
	public void doPaint(Matrix m);
}

class WindowsImp implements ImageImp {
	public void doPaint(Matrix m) {
		System.out.println("在windows显示图像");
	}
}

class LinuxImp implements ImageImp {
	public void doPaint(Matrix m) {
		System.out.print("在Linux操作系统中显示图像：");
	}
}

class UnixImp implements ImageImp {
	public void doPaint(Matrix m) {
		System.out.print("在Unix操作系统中显示图像：");
	}
}

class PNGImage extends Image {
	public void parseFile(String fileName) {
		Matrix m = new Matrix();
		imp.doPaint(m);
		System.out.println(fileName + "格式为PNG");
	}
}

class JPGImage extends Image {
	public void parseFile(String fileName) {
		Matrix m = new Matrix();
		imp.doPaint(m);
		System.out.println(fileName + "，格式为JPG。");
	}
}

class BMPImage extends Image {
	public void parseFile(String fileName) {
		Matrix m = new Matrix();
		imp.doPaint(m);
		System.out.println(fileName + "，格式为BMP。");
	}
}

class GIFImage extends Image {
	public void parseFile(String fileName) {
		Matrix m = new Matrix();
		imp.doPaint(m);
		System.out.println(fileName + "，格式为GIF。");
	}
}
