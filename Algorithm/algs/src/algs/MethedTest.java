package algs;
import java.util.Scanner;

public class MethedTest {

	public static void main(String[] args) {
		 Scanner scan = new Scanner(System.in);
		   // nextLine方式接收字符串
	        System.out.println("nextLine方式接收：");
	        // 判断是否还有输入
	        while (scan.hasNext()) {
	            String str2 = scan.nextLine();
	            System.out.println("输入的数据为：" + str2);
	        }
	        System.out.println("end");
	        scan.close();
	}
}