public class AssessmentTestController {
    // Wrapper class to store the input data in list
    public class wrapper{
      public String part_Number;
      public Integer quantity;
      public wrapper(String part_Number,Integer quantity){
        this.part_Number=part_Number;
        this.quantity= quantity;
      }
    }
    //Wrapper to store the output
    public class outPutResult{
      public String bom_pn;
      public Integer bom_qty;
      public String Disti_pn;
      public Integer Disti_qty;
      public Boolean Error_Flag;
      public outPutResult(String bom_pn,Integer bom_qty,String Disti_pn,Integer Disti_qty,Boolean Error_Flag){
        this.bom_pn = bom_pn;
        this.bom_qty = bom_qty;
        this.Disti_pn = Disti_pn;
        this.Disti_qty = Disti_qty;
        this.Error_Flag = Error_Flag;
      }
    }
    /*
    One Part Number will many times in Disti list too, but they need to be “aggregated” into one entry. In other words,
    Quantities will be aggregated. It is the job of the system to ensure that one part number will not exist multiple times in
    the Disti list. In case duplicate items (based on the Part Number) are provided as input for the Disti list, then the items
    should be “aggregated” by the solution to show only one item with the quantity as the sum of all the individual
    quantities provided in the input.
    */
    private static Map<String,Integer> aggregateDist(List<wrapper> wrapperDisList){
      Map<String,Integer> aggregateDistMap = new Map<String,Integer>();
      for(wrapper wq:wrapperDisList){
        if(aggregateDistMap.containsKey(wq.part_Number)){
          aggregateDistMap.put(wq.part_Number,aggregateDistMap.get(wq.part_Number) + wq.quantity);
        }else{
          aggregateDistMap.put(wq.part_Number,wq.quantity);
        }
      }
      return aggregateDistMap;
    }
    /*
    Compate bom and disti list and create the unified output list
    */
    @AuraEnabled
    public static List<outPutResult> bomAndDistiCompMethod(List<wrapper> bomList,List<wrapper> distiList){
      Map<String,Integer> aggregateDistMap = aggregateDist(distiList);
      List<outPutResult>  outputUnifiedList = new List<outPutResult>();

      if(!bomList.isEmpty()){
        for(wrapper bom:bomList){
          if(aggregateDistMap.containsKey(bom.part_Number)){
            Integer distQunatity = aggregateDistMap.get(bom.part_Number);
            //Compare dist quantity with bom quantity
            if(distQunatity > bom.quantity){
              outputUnifiedList.add(new outPutResult(bom.part_Number,bom.quantity,bom.part_Number,bom.quantity,false));
              aggregateDistMap.put(bom.part_Number,distQunatity-bom.quantity);
            } else{
              outputUnifiedList.add(new outPutResult(bom.part_Number,bom.quantity,bom.part_Number,distQunatity,false));
              aggregateDistMap.remove(bom.part_Number);
            }
          } else{
            outputUnifiedList.add(new outPutResult(bom.part_Number,bom.quantity,null,null,true));
          }

        }
      }

      //Remaining Disti items
      for(String distPartNo:aggregateDistMap.keySet()){
        outputUnifiedList.add(new outPutResult(null,null,distPartNo,aggregateDistMap.get(distPartNo),true));
      }
      return outputUnifiedList;
    }
}

/*
Anonymous script
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

// Output the result
for (AssessmentTestController.outPutResult ur : result) {
    System.debug('BoM Part Number: ' + ur.bom_pn + ', BoM Quantity: ' + ur.bom_qty +
                 ', Disti Part Number: ' + ur.Disti_pn + ', Disti Quantity: ' + ur.Disti_qty +
                 ', Error Flag: ' + ur.Error_Flag);
}
*/