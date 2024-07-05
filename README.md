---------------------------------------------------------------------------------------------------------------------

**Apex trigger scenarios**

---------------------------------------------------------------------------------------------------------------------
1. Write a trigger to identify the most recent contact when inserted for each account mark its  New_Contact__c field as checked and ensure that the New_Contact__c field is unchecked for the other contacts related to the same account  **(ContactTriggerHandler.updateRecentContacts)**

2. Whenever the opportunity is created and updated with the amount > 10000, send an email to the owner **(OpportunityTriggerHandler.SendEmailWhenOpportunityCU)**

3. When an account gets updated send an email to the owner of the account with recently modified contact details between the last update and the current update of the account **(AccountTriggerHandler.SendEmailWhenAccountUpdate)**

4. Write a trigger to create the contacts based on the user input on the number of contacts field in the Account object and throw an error if the user tries to make more than 10 contacts for the account **(AccountTriggerHandler.createContacts)**

5. Write a trigger that automatically links candidate and skill records. It should read skills listed in a text area field on the candidate, match them with existing skills, and connect them using a junction object called candidate skill also if a skill doesn’t then create the skill before establishing the connection. **(CandidateSkillLinkHandler.linkSkillWithCandidate)**

6. When a contact is inserted on an account, check if the account has existing opportunities. If so, update the account description with the total opportunity amount. if not, create a new opportunity. **(ContactTriggerHandler.updateOppAmountOnAccountWhenContactIsCreated)**

7. Write a apex trigger that updates the accounts description with opportunity name that has the highest amount.
**(OpportunityTriggerHandler.UpdateAccountWithOpportunityName)**

8. Write an apex trigger to update the related contacts with the latest country field value whenever it changes on the parent account record. **(AccountTriggerHandler.updateRelatedContacts)**

9. Write an apex trigger to link case to contact based on the supplied email.If the supplied email matches an existing contacts email the case should get linked to that contact otherwise a new contact shoud get crated and linked to that case.**(CaseTriggerhandler.linkContactToCase)**

10. Whenever create task checkbox is selected in the case, create a follow up task and automatically assign it to the Primary contact of the case account.**(CaseTriggerhandler.createTask)**

11. Write an apex trigger to create a related contact whenever the create contact checkbox is checked on account update or Insert  **(AccountTriggerHandler.createContactBasedOnCheckbox)**

12. Write a trigger to find top most parent from lower most account, If account has self look up and Account records has 10 levels of parent account **(AccountTriggerHandler.findTopMostParent)**

13. Write a trigger on prevent account from deletion if account having more than 2 contacts 
**(AccountTriggerHandler.validationCheckBeforeDelete)**

14. Whenever the opportunity type gets updated then insert a new opportunityContactRole according to the opportunity type.Delete the existing OpportunityContactRole and If there is no contact present of the same type as the opportunity then show an error.

15. Write an apex trigger to prevent deactivation of account with active contacts on it 
**(AccountTriggerHandler.activeAccountValidation)**

16. Create a Rollup-Summary trigger in Salesforce - Update the number contacts on the account object
**(ContactTriggerHandler.updateNumberOfContactsOnAccount)**

17. Write a trigger to update the total opportunities amount based on the status on account when opportunity creation and updation.

18. Write a trigger to update account and contact status to active when the opportunity stage is closed won **(OpportunityTriggerHandler.updateAccountAndContact)**

19. Write a trigger to update the the number of opportunityLineItem on account when opportunityLineItem creation /updation / deletion **(OpportunityLineItemHandler.updateCountOnAccount)**

20. Write a trigger to update the Parent Account's Description field with the Second Highest Amount from Related Opportunities.


---------------------------------------------------------------------------------------------------------------------

**Salesforce Integrations**

---------------------------------------------------------------------------------------------------------------------

1.  Write a callout apex class and parse the response using Map in salesforce 
    **(CalloutWithPublicUrl.getPublicInformationUsingMap)**

2.  Write a callout apex class and parse the response using Wrapper class in salesforce 
    **(CalloutWithPublicUrl.getPublicInformationUsingWrapperClass)**
---------------------------------------------------------------------------------------------------------------------

**JavaScript**

---------------------------------------------------------------------------------------------------------------------
1. Count the number of each fruits in the given array.

    const fruitArray = ['Orange','Apple','Orange','Orange','Apple'];
    const fruitCount = {};
    fruitArray.forEach((fruit)=>{
        if(fruitCount[fruit]){
            fruitCount[fruit] +=1;
        }else{
            fruitCount[fruit] =1;
        }
    })
    console.log("fruitCount"+JSON.stringify(fruitCount));

