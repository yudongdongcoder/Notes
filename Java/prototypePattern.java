import java.util.*;

public class prototypePattern {

	static void test(){
		PrototypeManager pm = PrototypeManager.getPrototypeManager();

		OfficialDocument doc1,doc2,doc3,doc4;

		doc1=pm.getOfficialDocument("far");
		doc1.display();
		doc2=pm.getOfficialDocument("far");
		doc2.display();
		System.out.println(doc1==doc2);

		doc3=pm.getOfficialDocument("srs");
		doc3.display();
		doc4=pm.getOfficialDocument("srs");
		doc4.display();
		System.out.println(doc3==doc4);
	}

}

interface OfficialDocument extends Cloneable {
	public OfficialDocument clone();

	public void display();
}

class FAR implements OfficialDocument {
	public OfficialDocument clone() {
		OfficialDocument far = null;
		try {
			far = (OfficialDocument) super.clone();
		} catch (CloneNotSupportedException e) {
			System.out.println("不支持复制！");
		}
		return far;
	}

	public void display() {
		System.out.println("《可行性分析报告》");
	}
}

class SRS implements OfficialDocument {
	public OfficialDocument clone() {
		OfficialDocument srs = null;
		try {
			srs = (OfficialDocument) super.clone();
		} catch (CloneNotSupportedException e) {
			System.out.println("不支持复制！");
		}
		return srs;
	}

	public void display() {
		System.out.println("《软件需求规格说明书》");
	}
}

class PrototypeManager {
	private Hashtable ht = new Hashtable();
	private static PrototypeManager pm = new PrototypeManager();

	private PrototypeManager() {
		ht.put("far", new FAR());
		ht.put("srs", new SRS());
	}
	public void addOfficialDocument(String key, OfficialDocument doc)
	{
		ht.put(key, doc);
	}
	  public OfficialDocument  getOfficialDocument(String key)
      {
             return  ((OfficialDocument)ht.get(key)).clone();
      }
	  public static PrototypeManager  getPrototypeManager()
      {
             return pm;
      }
}
