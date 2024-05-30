#Apex trigger scenarios

1. Write a trigger to identify the most recent contact when inserted for each account mark its  New_Contact__c field as checked and ensure that the New_Contact__c field is unchecked for the other contacts related to the same account (ContactTriggerHandler.updateRecentContacts)
2. Whenever the opportunity is created and updated with the amount > 10000, send an email to the owner (OpportunityTriggerHandler.SendEmailWhenOpportunityCU)
3. When an account gets updated send an email to the owner of the account with recently modified contact details between the last update and the current update of the account(AccountTriggerHandler.SendEmailWhenAccountUpdate)
4. Write a trigger to create the contacts based on the user input on the number of contacts field in the Account object and throw an error if the user tries to make more than 10 contacts for the account(AccountTriggerHandler.createContacts)
5. Write a trigger that automates the linking of candidate and skill records. It should read skills listed in a text area field on the candidate, match them with existing skills, and connect them using a junction object called candidate skill also if a skill doesn’t then create the skill before establishing the connection.(CandidateSkillLinkHandler.linkSkillWithCandidate)
6. When a contact is inserted on an account, check if the account has existing opportunities. If so, update the account description with the total opportunity amount. if not, create a new opportunity.(ContactTriggerHandler.updateOppAmountOnAccountWhenContactIsCreated)


# Salesforce DX Project: Next Steps

Now that you’ve created a Salesforce DX project, what’s next? Here are some documentation resources to get you started.

## How Do You Plan to Deploy Your Changes?

Do you want to deploy a set of changes, or create a self-contained application? Choose a [development model](https://developer.salesforce.com/tools/vscode/en/user-guide/development-models).

## Configure Your Salesforce DX Project

The `sfdx-project.json` file contains useful configuration information for your project. See [Salesforce DX Project Configuration](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_ws_config.htm) in the _Salesforce DX Developer Guide_ for details about this file.

## Read All About It

- [Salesforce Extensions Documentation](https://developer.salesforce.com/tools/vscode/)
- [Salesforce CLI Setup Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_setup.meta/sfdx_setup/sfdx_setup_intro.htm)
- [Salesforce DX Developer Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_intro.htm)
- [Salesforce CLI Command Reference](https://developer.salesforce.com/docs/atlas.en-us.sfdx_cli_reference.meta/sfdx_cli_reference/cli_reference.htm)
# salesforceCode
