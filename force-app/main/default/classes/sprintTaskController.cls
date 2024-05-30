public with sharing class sprintTaskController {
  @AuraEnabled(cacheable=true)
  public static List<Sprint_tasks__c> getSprintTasks(){
    return [SELECT id,Leave_Date_if_any__c,Manager_Name__c,Name,Task_Description__c,Contact__r.Name,
    Tesct__c,Employee_Name__c,Is_TimeSheet_filled__c,Is_TimeSheet_filled_Check__c
    FROM Sprint_tasks__c];
  } 

  // public static String getHTMLTable(
  // ) {
  //   EmailTemplate tempID = [
  //     SELECT Id, HTMLValue, Name
  //     FROM EmailTemplate
  //     WHERE Name = :'SprintUpdate'
  //   ];
  //   String emailBody = tempID.HTMLValue;
  //   String htmlBody = '';
  //   htmlBody +=
  //     '<div style="overflow-x: auto;">' +
  //     '<div style="font-family:comic sans ms,cursive"><br/>Hello All,<br/>Please find below the functional test results, DT-wise for '+'DSadsdfsdf'+'</div></br><table border="1" style="border-collapse: collapse"><tr style="background-color: #004d99;color: white;"><th>Employee Name</th><th>Task Description</th><th>Manager</th></tr>';
  //   for (String key : countMap.keySet()) {
  //     htmlBody +=
  //       setBoldText(countMap.get(key).Name, 1) +
  //       countMap.get(key).Name +
  //       setBoldText(countMap.get(key).Name, 2) +
  //       Integer.valueOf(countMap.get(key).passCount) +
  //       setBoldText(countMap.get(key).Name, 2) +
  //       Integer.valueOf(countMap.get(key).failCount) +
  //       setBoldText(countMap.get(key).Name, 2) +
  //       Integer.valueOf(countMap.get(key).skipCount) +
  //       setBoldText(countMap.get(key).Name, 2) +
  //       Integer.valueOf(countMap.get(key).totalCount) +
  //       getTextColorByPercentage(
  //         countMap.get(key).passCount,
  //         countMap.get(key).totalCount,
  //         countMap.get(key).Name
  //       ) +
  //       getPassPercentage(
  //         countMap.get(key).passCount,
  //         countMap.get(key).totalCount
  //       ) +
  //       '%' +
  //       '</td></tr>';
  //   }
  //   htmlBody +=
  //     '</table><br/>' +
  //     getEmailTemplateBody(emailBody, ftData, prevousFTData) +
  //     '</div>';
  //   return htmlBody;
  // }

}