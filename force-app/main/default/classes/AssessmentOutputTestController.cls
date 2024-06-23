public class AssessmentOutputTestController {
  @AuraEnabled
  public static String getCompDetails(){
      List<AssessmentTestController.wrapper> bomList = new List<AssessmentTestController.wrapper>();
      bomList.add(new AssessmentTestController.wrapper('ABC', 2));
      bomList.add(new AssessmentTestController.wrapper('XYZ', 1));
      bomList.add(new AssessmentTestController.wrapper('IJK', 1));
      bomList.add(new AssessmentTestController.wrapper('ABC', 1));
      bomList.add(new AssessmentTestController.wrapper('IJK', 1));
      bomList.add(new AssessmentTestController.wrapper('XYZ', 2));
      bomList.add(new AssessmentTestController.wrapper('DEF', 2));

      List<AssessmentTestController.wrapper> distiList = new List<AssessmentTestController.wrapper>();
      distiList.add(new AssessmentTestController.wrapper('XYZ', 2));
      distiList.add(new AssessmentTestController.wrapper('GEF', 2));
      distiList.add(new AssessmentTestController.wrapper('ABC', 4));
      distiList.add(new AssessmentTestController.wrapper('IJK', 2));
      List<AssessmentTestController.outPutResult> result = AssessmentTestController.bomAndDistiCompMethod(bomList, distiList);
      return JSON.serialize(result);
    }
}