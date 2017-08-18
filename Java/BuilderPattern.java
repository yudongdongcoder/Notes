
public class BuilderPattern {
	static void test() {
		ActorBuilder ab = new HeroBuilder();
		ActorController actorController = new ActorController();
		Actor actor = actorController.construct(ab);
		System.out.println(actor.getType());
	}
}

// Product
class Actor
{
	  private  String type; //角色类型
      private  String sex; //性别
      private  String face; //脸型
      private  String costume; //服装
      private  String hairstyle; //发型
     
      public  void setType(String type) {
             this.type  = type;
      }
      public  void setSex(String sex) {
             this.sex  = sex;
      }
      public  void setFace(String face) {
             this.face  = face;
      }
      public  void setCostume(String costume) {
             this.costume  = costume;
      }
      public  void setHairstyle(String hairstyle) {
             this.hairstyle  = hairstyle;
      }
      public  String getType() {
             return  (this.type);
      }
      public  String getSex() {
             return  (this.sex);
      }
      public  String getFace() {
             return  (this.face);
      }
      public  String getCostume() {
             return  (this.costume);
      }
      public  String getHairstyle() {
             return  (this.hairstyle);
      }
}
// abstract builder
abstract class ActorBuilder
{
	protected Actor actor = new Actor();
	 public  abstract void buildType();
     public  abstract void buildSex();
     public  abstract void buildFace();
     public  abstract void buildCostume();
     public  abstract void buildHairstyle();
     
     public Actor createActor()
     {
            return actor;
     }
     
}

//concrete builder
class HeroBuilder extends ActorBuilder
{
       public  void buildType()
       {
              actor.setType("英雄");
       }
       public  void buildSex()
       {
              actor.setSex("男");
       }
       public  void buildFace()
       {
              actor.setFace("英俊");
       }
       public  void buildCostume()
       {
              actor.setCostume("盔甲");
       }
       public  void buildHairstyle()
       {
              actor.setHairstyle("飘逸");
       }    
}

class AngelBuilder extends ActorBuilder
{
       public  void buildType()
       {
              actor.setType("天使");
       }
       public  void buildSex()
       {
              actor.setSex("女");
       }
       public  void buildFace()
       {
              actor.setFace("漂亮");
       }
       public  void buildCostume()
       {
              actor.setCostume("白裙");
       }
       public  void buildHairstyle()
       {
              actor.setHairstyle("披肩长发");
       }    
}

class DevilBuilder extends ActorBuilder
{
       public  void buildType()
       {
              actor.setType("恶魔");
       }
       public  void buildSex()
       {
              actor.setSex("妖");
       }
       public  void buildFace()
       {
              actor.setFace("丑陋");
       }
       public  void buildCostume()
       {
              actor.setCostume("黑衣");
       }
       public  void buildHairstyle()
       {
              actor.setHairstyle("光头");
       }    
}

//Director

class ActorController
{
    //逐步构建复杂产品对象
       public Actor construct(ActorBuilder ab)
       {
              Actor actor;
              ab.buildType();
              ab.buildSex();
              ab.buildFace();
              ab.buildCostume();
              ab.buildHairstyle();
              actor=ab.createActor();
              return actor;
       }
}





