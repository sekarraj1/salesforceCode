**Apex trigger scenarios**
------------------------------------------------------------------------------------------------------------------

1. Write a trigger to identify the most recent contact when inserted for each account mark its  New_Contact__c field as checked and ensure that the New_Contact__c field is unchecked for the other contacts related to the same account  **(ContactTriggerHandler.updateRecentContacts)**

2. Whenever the opportunity is created and updated with the amount > 10000, send an email to the owner **(OpportunityTriggerHandler.SendEmailWhenOpportunityCU)**

3. When an account gets updated send an email to the owner of the account with recently modified contact details between the last update and the current update of the account **(AccountTriggerHandler.SendEmailWhenAccountUpdate)**

4. Write a trigger to create the contacts based on the user input on the number of contacts field in the Account object and throw an error if the user tries to make more than 10 contacts for the account **(AccountTriggerHandler.createContacts)**

5. Write a trigger that automates the linking of candidate and skill records. It should read skills listed in a text area field on the candidate, match them with existing skills, and connect them using a junction object called candidate skill also if a skill doesn’t then create the skill before establishing the connection. **(CandidateSkillLinkHandler.linkSkillWithCandidate)**

6. When a contact is inserted on an account, check if the account has existing opportunities. If so, update the account description with the total opportunity amount. if not, create a new opportunity. **(ContactTriggerHandler.updateOppAmountOnAccountWhenContactIsCreated)**

7. Write a apex trigger that updates the accounts description with opportunity name that has the highest amount.
**(OpportunityTriggerHandler.UpdateAccountWithOpportunityName)**

8. Write an apex trigger to update the related contacts with the latest country field value whenever it changes on the parent account record. **(AccountTriggerHandler.updateRelatedContacts)**

9. Write an apex trigger to link case to contact based on the supplied email.If the supplied email matches an existing contacts email the case should get linked to that contact otherwise a new contact shoud get crated and linked to that case.


